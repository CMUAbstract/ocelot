#include "checkpoint.h"
#include <libio/console.h>
#include <libcapybara/power.h>
#include <libmsp/periph.h>

//Debug logging, not checkpoint logging
#define LOGGING 0
#define DEBUG_LOG 1
__nv unsigned chkpt_finished = 0;
__nv unsigned atomic_depth = 0;

__nv unsigned __numBoots = 0;
__nv unsigned true_first = 1;

__nv unsigned int * SAVED_PC = (unsigned int *) 0xFB80;
__nv unsigned int* CURR_SP = (unsigned int *) 0xFBC4;
__nv unsigned int* RESTORE_STACK = (unsigned int *) 0xFBC0;

//for testing correctness intermittently
//total rb count
__nv unsigned rho = 0;
//bit vector, 16 should be enough
__nv unsigned sensorArray = 0;

#define CORRECTNESS 0

#if CORRECTNESS == 1
__nv unsigned failCount = 1;
void setArray(unsigned index)
{
  sensorArray |= (0x1 << index);
}

unsigned testArray(unsigned index)
{
  if (!((sensorArray >> index) & 0x1)) {
    //triple flip of pin 0 is error code
      P1OUT |= BIT0;
      P1DIR |= BIT0;
      P1OUT &= ~BIT0;
  
      P1OUT |= BIT0;
      P1DIR |= BIT0;
      P1OUT &= ~BIT0;

      P1OUT |= BIT0;
      P1DIR |= BIT0;
      P1OUT &= ~BIT0;
      PRINTF("ERROR: untimely value %u !\r\n", index);
      return 0;
  }
  return 1;
}
#endif

//__nv unsigned int* RESTORE_STACK = (unsigned int*)0xFBC8
//local helper funcs
void save_stack();
inline void restore_stack() __attribute__((always_inline));


extern int __stack; //should be the lowest addr in the stack;

/**
 * @brief dirtylist to save src address
 */
__nv uint8_t** data_src_base = &data_src;
/**
 * @brief dirtylist to save dst address
 */
__nv uint8_t** data_dest_base = &data_dest;
/**
 * @brief dirtylist to save size
 */
__nv unsigned* data_size_base = &data_size;

/**
 * @brief len of dirtylist
 */
__nv volatile unsigned num_dirty_gv=0;

/**
 * @brief double buffered context
 */
__nv context_t context_1 = {
			    .numRollBack = 0,
			    .curr_m = Jit,
};
/**
 * @brief double buffered context
 */
__nv context_t context_0 = {
			    
      .numRollBack = 0,
      .curr_m = Jit,
};
/**
 * @brief current context
 */
__nv context_t * volatile curctx = &context_0;


/*Hax for getting things to work on cont power*/
#ifdef LIBCAPYBARA_CONT_POWER
void dummy_func() {}
#endif

void on_atomic_reboot()
{
  if(__numBoots == 0xFFFF) {
    clear_isDirty();
    __numBoots++;
  }
  //rollback log entries
  while(curctx->numRollBack) {
    unsigned rollback_idx =curctx->numRollBack -1;
    uint8_t* loc_data_dest = *(data_dest_base + rollback_idx);
    uint8_t* loc_data_src = *(data_src_base + rollback_idx);
    unsigned loc_data_size = *(data_size_base + rollback_idx);
    
    memcpy(loc_data_dest, loc_data_src, loc_data_size);
    //     PRINTF("Restoring src: %u dest: %u\r\n", *loc_data_src, *loc_data_dest);
    // PRINTF("From Addrs: %x and %x\r\n", (unsigned)loc_data_src, (unsigned)loc_data_dest);
    curctx->numRollBack--;
  }


}

//End of Atomic section/start of jit (or sync?) region, switch context to refer to next section
//thereby commiting this atomic region
//watch out for atomicity bugs
void end_atomic()
{
  //must be double buffered in the case that power fails here
  //jit not yet enabled
  //    PRINTF("Atomic Depth at end %u \r\n", atomic_depth);
  context_t* next_ctx;
  //this is safe because jit checkpointing is not enabled,
  //the entire nested region will be re-run
  if (atomic_depth > 0) {
    atomic_depth--;
  }

  else if (atomic_depth == 0) {
    //get which pointer it should be, to always have a valid context
    next_ctx = (curctx == &context_0 ? &context_1 : &context_0);
    next_ctx->curr_m = Jit;
    next_ctx->numRollBack = 0;
    //interrupts are already enabled -- needs only to switch the context
    //COMP_VBANK(INT) |= COMP_VBANK(IE);
        //atomic update of context
    curctx = next_ctx;
    //now counts only number of boots in atomic regions
    __numBoots = 1;
  }
  
  //purely for testing purposes on continuous power, but not if trying to get accurate overheads
#ifdef LIBCAPYBARA_CONT_POWER
#if RUNTIME_EXPERIMENTS == 0   
  //    checkpoint();
  // dummy_func();
#endif
#endif
  
}

static volatile unsigned dummy = 0;
//End of JIT section/start of atomic, switch context to refer to next section
//checkpoint volatile state.
//watchout for atomicity bugs
void start_atomic()
{
  //must be double buffered in the case that power fails here
  //jit still enabled
  //PRINTF("Atomic Depth %u at start\r\n", atomic_depth);
  //don't activate for nested region
  //interrupts will be disabled for their crimes >:(
  __disable_interrupt();
  if (curctx->curr_m == Atomic) {
    //this is cleared on reboot, no need worry about running twice without the match dec.
    atomic_depth++;
    return;
  }

  context_t* next_ctx;
  //get which pointer it should be, to always have a valid context
  next_ctx = (curctx == &context_0 ? &context_1 : &context_0);
  next_ctx->curr_m = Atomic;
  next_ctx->numRollBack = 0;
  //atomic update of context
  //disable vbank interrupts here
  //COMP_VBANK(INT) &= ~COMP_VBANK(IE);
  curctx = next_ctx;
  //checkpoint the volatile state?
  //after roll back, reboot in atomic region will start from here
  checkpoint();
  //to skip capy shutdown
  dummy = 0;
  chkpt_finished =1;
  __enable_interrupt();
  //re-enable to prevent cold start
  //COMP_VBANK(INT) |= COMP_VBANK(IE);
 
}

/*Add an entry to the log*/
void log_entry(uint8_t* orig_addr, uint8_t* backup_addr, size_t var_size)
{
  unsigned nrb = curctx->numRollBack;
  *(data_size_base + nrb) = var_size;
  *(data_dest_base + nrb) = orig_addr;
  *(data_src_base + nrb) = backup_addr;
  //PRINTF("Saving src: %u dest: %u\r\n", *orig_addr, *backup_addr);
  curctx->numRollBack = nrb + 1;
}


void checkpoint() {
  //save the registers
  //start with status reg for reasons
  //the status reg
  /*
#ifndef LIBCAPYBARA_CONT_POWER
  if (curctx->curr_m==Jit) {
    COMP_VBANK(INT) &= ~COMP_VBANK(IE);
  }
#endif
  */
  __asm__ volatile ("MOV R2, &0xFB88");

  
  //this is R1 (SP), but it will be R0 (PC) on restore
  //(since we don't want to resume in chckpnt obvi, but after the return)
  //if in JIT mode, we need to add four to skip capy shutdown
  if (curctx->curr_m==Atomic||true_first) {
    __asm__ volatile ("MOVX.W 0(R1), &0xFB80");
    
  } else {
#ifdef LIBCAPYBARA_CONT_POWER
    __asm__ volatile ("MOVX.W 0(R1), &0xFB80");
    
#else
    __asm__ volatile ("ADD #4, 0(R1)");
    __asm__ volatile ("MOVX.W 0(R1), &0xFB80");
    __asm__ volatile ("SUB #4, 0(R1)");
#endif
   
    }

  //for debug of sp
  __asm__ volatile ("MOVX.W R1, &0xFBC4");
  //what we want R1 to be on restoration
  //Add 2 instead of 4 for alignment issues?
  __asm__ volatile ("ADD #2, R1");
  __asm__ volatile ("MOVX.W R1, &0xFB84");
  __asm__ volatile ("SUB #2, R1");

  #if LOGGING
  unsigned i  = 0;
  while(i < 20) {
    PRINTF("checkpoint: first batch done\r\n");
    PRINTF("old stack val %u new val %u\r\n", *((unsigned int*) 0xFB80), *((unsigned int*)0xFB84));
    i++;
  }
  i = 0;
#endif
  
  
  //R3 is constant generator, doesn't need to be restored
  
  //the rest are general purpose regs
  __asm__ volatile ("MOVX.W R4, &0xFB90");
  __asm__ volatile ("MOVX.W R5, &0xFB94");
  __asm__ volatile ("MOVX.W R6, &0xFB98");
  __asm__ volatile ("MOVX.W R7, &0xFB9c");

  __asm__ volatile ("MOVX.W R8, &0xFBA0");
  __asm__ volatile ("MOVX.W R9, &0xFBA4");
  __asm__ volatile ("MOVX.W R10, &0xFBA8");
  __asm__ volatile ("MOVX.W R11, &0xFBAc");

  __asm__ volatile ("MOVX.W R12, &0xFBB0");
  __asm__ volatile ("MOVX.W R13, &0xFBB4");
  __asm__ volatile ("MOVX.W R14, &0xFBB8");
  __asm__ volatile ("MOVX.W R15, &0xFBBc");

  save_stack();
  
  chkpt_finished = 1;
  /*
#ifndef LIBCAPYBARA_CONT_POWER
  if (curctx->curr_m==Jit) {
    COMP_VBANK(INT) |= COMP_VBANK(IE);
  }
  
#endif
  */

}

void restore_vol() {
  //restore the registers
  //but no checkpointing here
  
  P1OUT |= BIT1;
  P1DIR |= BIT1;
  P1OUT &= ~BIT1;

  //if testing for correctness, clear the sensor array
#if CORRECTNESS == 1
  sensorArray = 0;
#endif
  
#ifndef LIBCAPYBARA_CONT_POWER
  
  //if (curctx->curr_m==Jit) {
    
  // COMP_VBANK(INT) &= ~COMP_VBANK(IE);
    //}
#endif
  
  //if (!chkpt_finished) {
    //flip a pin or smthing 
    //return;
    //}
  
  unsigned i = 0;
  chkpt_finished = 0;
  __numBoots +=1;
  
  //__asm__ volatile ("MOVX.W R1, &0xFBC0");

  __asm__ volatile ("MOVX.W &0xFB84, R1");

  //this is inlined now
  restore_stack();

  P1OUT |= BIT1;
  P1DIR |= BIT1;
  P1OUT &= ~BIT1;
  
  P1OUT |= BIT1;
  P1DIR |= BIT1;
  P1OUT &= ~BIT1;

#if LOGGING
  while(i < 10) {
    PRINTF("sp done\r\n");
    i++;
  }
  i = 0;
  #endif
  __asm__ volatile ("MOVX.W &0xFB90, R4");
  __asm__ volatile ("MOVX.W &0xFB94, R5");
  __asm__ volatile ("MOVX.W &0xFB98, R6");
  __asm__ volatile ("MOVX.W &0xFB9c, R7");

  #if LOGGING
  while(i < 10) {
    PRINTF("first batch done\r\n");
    //PRINTF("old stack val %u new val %u\r\n", *(DEBUG_LOC), *((unsigned int*)0xFB84));
    i++;
  }
  i = 0;
  #endif
  __asm__ volatile ("MOVX.W &0xFBB0, R12");
  __asm__ volatile ("MOVX.W &0xFBB4, R13");
  __asm__ volatile ("MOVX.W &0xFBB8, R14");
  __asm__ volatile ("MOVX.W &0xFBBc, R15");

  /*
#if LOGGING
  while(i < 5) {
    PRINTF("third batch done\r\n");
    i++;
  }
  i = 0;
#endif
  */
  //this batch of registers sometimes gave issues, but restoring in this order works
  __asm__ volatile ("MOVX.W &0xFBA0, R8");
  __asm__ volatile ("MOVX.W &0xFBA4, R9");
  __asm__ volatile ("MOVX.W &0xFBA8, R10");
  __asm__ volatile ("MOVX.W &0xFBAc, R11");

  /*
#if LOGGING
  while(i < 5) {
    PRINTF("problematic batch done\r\n");
    i++;
  }
  i = 0;
#endif  
  */
   //last but not least, move regs 2 to 0
  __asm__ volatile ("MOVX.W &0xFB88, R2");
  __asm__ volatile ("MOVX.W &0xFB84, R1");
  // /*
#ifndef LIBCAPYBARA_CONT_POWER

  //if (curctx->curr_m==Jit) {

  //  COMP_VBANK(INT) |= COMP_VBANK(IE);
    //}
#endif
  //*/
  __asm__ volatile ("MOVX.W &0xFB80, R0");
  //pc has been changed, can't do anything here!!
}


/*Function that copies the stack to nvmem*/
void save_stack()
{
  uint16_t *stack_start = (uint16_t*)(&__stack);
  //save this val to 0xFBC0
  *(unsigned *)0xFBC0 = (unsigned) stack_start;
#if LOGGING
  PRINTF("save: stack is from %u to %u\r\n", stack_start, *CURR_SP);
#endif
  unsigned int* save_point = 0xFBC8;
  //WARNING!! Deref of CURR_SP does not give the value stored at 0xfbc4
  //
  //  unsigned iter = 0;
  unsigned sp_vol = *(unsigned int *)0xFBC4;
  while( (unsigned)stack_start > sp_vol) {
    *save_point = *stack_start;
    save_point++;
    stack_start--;
    //iter++;
  }
  //PRINTF("stack had %u items\r\n", iter);

}


/*Function that restores the stack from nvmem*/
void inline restore_stack()
{
  uint16_t *stack_start = (uint16_t*)(&__stack);
  //or possibly
#if LOGGING
  PRINTF("restore: stack is from %u to %u\r\n", stack_start, *CURR_SP);
#endif
  unsigned int* save_point = 0xFBC8;
  unsigned sp_vol = *(unsigned int *)0xFBC4;
  while( (unsigned)stack_start > sp_vol) {
    *stack_start = *save_point;
    save_point++;
    stack_start--;
  }


}

//entry after reboot
// call init and appropriate rb function for current Mode.
//#if MAIN
void entry() {
  
  if(true_first) {
    //in the case that the first checkpoint in the program is not reached.
    //need to make sure true_first is accurate.
    checkpoint();
    dummy = 0;
    true_first = 0;
    __numBoots = 1;
    return;
    //dead region
    }
  //PRINTF("Curr mode is: %u\r\n", curctx->curr_m);
  switch(curctx->curr_m) {
  case Atomic:
    atomic_depth = 0;
    on_atomic_reboot();
    //fall through
  default:
    /*
    P1OUT |= BIT1;
      P1DIR |= BIT1;
      P1OUT &= ~BIT1;
  
      P1OUT |= BIT1;
      P1DIR |= BIT1;
      P1OUT &= ~BIT1;
      
      P1OUT |= BIT1;
      P1DIR |= BIT1;
      P1OUT &= ~BIT1;
    */
      //same for jit and atomic
      restore_vol();
      //deadregion
  }
  //return 0;
  return;
}
//#endif

//only compile if not continuous power, otherwise shutdown isn't define

#ifndef LIBCAPYBARA_CONT_POWER
//the low power interrupt handler
__attribute__ ((interrupt(COMP_VECTOR(LIBCAPYBARA_VBANK_COMP_TYPE))))
void COMP_VBANK_ISR (void)
{
  switch (__even_in_range(COMP_VBANK(IV), 0x4)) {
  case COMP_INTFLAG2(LIBCAPYBARA_VBANK_COMP_TYPE, IIFG):
    break;
  case COMP_INTFLAG2(LIBCAPYBARA_VBANK_COMP_TYPE, IFG):
    COMP_VBANK(INT) &= ~COMP_VBANK(IE);
    COMP_VBANK(CTL1) &= ~COMP_VBANK(ON);
    if (curctx->curr_m == Atomic) {
      P1OUT |= BIT5;
      P1DIR |= BIT5;
      P1OUT &= ~BIT5;
      //gives some strange behaviour
      capybara_shutdown();
    }
    else {
      // Checkpoint needs to be **immediately** followed by capybara
      // shutdown for this to work
        P1OUT |= BIT0;
	P1DIR |= BIT0;
	P1OUT &= ~BIT0;
	//	PRINTF("Shutting down\r\n");
	checkpoint();
	//      dummy = 0;
	capybara_shutdown();
    }
    break;
  }
  // Shouldn't reach here
  P1OUT |= BIT4;
  P1DIR |= BIT4;
  P1OUT &= ~BIT4;
}
#endif
