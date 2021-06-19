#include <stdint.h>
#include <stddef.h>
#include <libmsp/mem.h>
#include <libcapybara/power.h>
#include <libmsp/periph.h>

//things other pieces might need to see
extern unsigned chkpt_finished;
extern unsigned __numBoots;
extern unsigned chkpt_first_taken;
extern unsigned atomic_depth;

typedef enum { Atomic, Jit, Sync} Mode;

/* Checkpoint context */
typedef struct _context_t {
  /* Execution mode: atomic, jit, sync(?) */
  Mode curr_m;
  /* Track number of entries to roll back*/
  unsigned numRollBack;
} context_t;

extern uint8_t* data_src[];
extern uint8_t* data_dest[];
extern unsigned data_size[];
extern uint8_t** data_src_base;
extern uint8_t** data_dest_base;
extern unsigned* data_size_base;

extern context_t * volatile curctx;
//for double buffering
extern context_t context_0;
extern context_t context_1;

/** @brief LLVM generated function that clears all isDirty_ array */
extern void clear_isDirty();


/*Function Declarations*/
void log_entry(uint8_t *data_src, uint8_t *data_dest, size_t var_size);

void commit(void);
void checkpoint(void);
void on_atomic_reboot(void);
void end_atomic(void);
void start_atomic(void);
//void ul_checkpoint(void);
void restore_vol(void);
void entry(void);
void COMP_VBANK_IST(void);
