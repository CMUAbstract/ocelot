#![no_std]
#![feature(core_panic)]
#![feature(const_in_array_repeat_expressions)]
//#![no_builtins]
//GUIDE: import the file with the intermittent macros, structs, etc.
include!("intermittent.rs");
//GUIDE: put c driver funcs, etc., in here
extern {
   
    fn gpioTwiddle() -> ();
 
}
//GUIDE: IO op annotations as pub static function pointer
#[no_mangle]
pub static IO_NAME : fn(Letter) -> Sample =  acquire_sample;


//NOTE TO SELF:This is necessary! It causes everything to be visible to C (TODO make cleaner)
#[no_mangle]
pub extern "C" fn _entry() {
    app();
}

const LOOP_IDX:u16 = 5;

const NIL:usize =  0; // like NULL, but for indexes, not real pointers

const DICT_SIZE:u16 = 512;
const BLOCK_SIZE:u16 = 64;

const NUM_LETTERS_IN_SAMPLE:u16 =2;
const LETTER_MASK:u16 = 0x00FF;
const LETTER_SIZE_BITS:usize = 8;
const NUM_LETTERS:u16 =  LETTER_MASK + 1;
type Index = usize;
type Letter = u16;
type Sample = u16;

// NOTE: can't use pointers, since need to ChSync, etc
struct Node {
	letter:Letter, // 'letter' of the alphabet
	sibling:Index, // this node is a member of the parent's children list
	child:Index   // link-list of children
}
type Dict = [Node;DICT_SIZE as usize];
/*struct Dict {
	nodes:[Node;DICT_SIZE as usize],
	node_count:u16
} */

type Log = [Index;BLOCK_SIZE as usize];
/*struct Log {
	data:[Index;BLOCK_SIZE as usize],
	count:u16,
	sample_count:u16,
} */
//__attribute__((always_inline))
fn print_log(log:&Log, log_count:&u16, log_sample_count:&u16)
{
    unsafe{
	//manually guard output
	start_atomic();
	printf(b"rate: samples/block: %l/%l\r\n\0".as_ptr(), *log_sample_count as u32, *log_count as u32);
	//printf(b"atomic depth: %l\r\n\0".as_ptr(), atomic_depth as u32);
	end_atomic();
	//	BLOCK_PRINTF("compressed block:\r\n");
	start_atomic();
	for i in 0..*log_count {
	    //
	    printf(b"%04x \0".as_ptr(), log[i as usize] as u32);
	    //		if (i > 0 && ((i + 1) & (8 - 1)) == 0){
	    //		}
	    //		BLOCK_PRINTF("\r\n");
	    //	}
	    //	if ((log->count & (8 - 1)) != 0){
	}
	printf(b"\r\n\0".as_ptr());
	end_atomic();
    }
    
    if *log_sample_count != 353 {
	unsafe{
	start_atomic();
	unsafe{printf(b"print log exit tripped!\r\n\0".as_ptr())}
	//exit(0);
	    end_atomic();
	}
    }
    
}


fn acquire_sample(prev_sample:Letter) -> Sample
{
	//letter_t sample = rand() & 0x0F;
	let sample:Letter = (prev_sample as Sample + 1) & 0x03;
	return sample;
}

fn init_dict(dict:&mut Dict, node_count:&mut u16) -> ()
{
	
	//LOG("init dict\r\n");
    for l in 0..NUM_LETTERS {
	dict[l as usize].letter = l;
	dict[l as usize].sibling = 0;
	dict[l as usize].child = 0;
	//dict.node_count = dict.node_count + 1;
//	unsafe{printf(b"init node l %l s %l c %l count %l\r\n\0".as_ptr(), dict.nodes[l as usize].letter as u32,
//		      dict.nodes[l as usize].sibling as u32, dict.nodes[l as usize].child as u32, dict.node_count as u32);}
		
    }
    *node_count = 256;

}

fn find_child(letter:Letter, parent:Index, dict:&Dict) -> Index
{
    //atomic_start();
    let parent_node:&Node = &dict[parent];
    let mut ret:usize = NIL;
	//LOG("find child: l %u p %u c %u\r\n", letter, parent, parent_node->child);

	if parent_node.child == NIL {
		//LOG("find child: not found (no children)\r\n");
		return NIL;
	}

	let mut sibling:Index = parent_node.child;
	while sibling != NIL { //bound: temp

		let sibling_node:&Node = &dict[sibling];

		//LOG("find child: l %u, s %u l %u s %u\r\n", letter,
		//		sibling, sibling_node->letter, sibling_node->sibling);

		if sibling_node.letter == letter { // found
			//LOG("find child: found %u\r\n", sibling);
		    
		    ret = sibling;
		    break;
		} else {
			sibling = sibling_node.sibling;
		}
	}

	//LOG("find child: not found (no match)\r\n");
    //atomic_end();
    return ret;
}

fn add_node(letter:Letter, parent:Index, dict:&mut Dict, node_count:&mut u16) -> ()
{
    if *node_count == DICT_SIZE {
	
	unsafe{printf(b"add node: table full\r\n\0".as_ptr());}
	return;
	
    }
    //Make a local var for the new node
    let mut node:Node = Node{letter:letter, sibling:NIL, child:NIL};
    
    let node_index:Index = *node_count as usize;
    let child:Index = dict[parent].child;
    *node_count = *node_count + 1;
    //unsafe {printf(b"adding node: i %l l %u, p: %l pc %l\r\n\0".as_ptr(),node_index as u32, letter as u32, parent as u32 as u32, child);}
    if child != 0 {
	//LOG("add node: is sibling\r\n");
	// Find the last sibling in list
	let mut sibling:Index = child;
	//let mut sibling_node:&Node = &dict[sibling];
	let mut sibling_next:Index = sibling;
	while sibling_next != NIL { //temp bound for test
	    // unsafe{printf(b"add node: sibling %u, l %u s %u\r\n\0".as_ptr(),
	    //		  sibling as u32, letter as u32, sibling_node.sibling as u32);}
	    // unsafe {gpioTwiddle();}
	    sibling = sibling_next;
	    sibling_next = dict[sibling].sibling;
	}

	// Link-in the new node
	//unsafe{printf(b"add node: last sibling %u\r\n\0".as_ptr(), sibling as u32)};
	dict[sibling].sibling = node_index;
    } else {
	//  unsafe{printf(b"add node: is only child\r\n\0".as_ptr())};
	dict[parent].child = node_index;
    }
    dict[node_index].letter = node.letter;
    dict[node_index].sibling = node.sibling;
    dict[node_index].child = node.child;

}

fn append_compressed(parent:Index, log:&mut Log, log_count:&mut u16) -> ()
{
    //LOG("append comp: p %u cnt %u\r\n", parent, log->count);
    log[*log_count as usize] = parent;
    *log_count= *log_count + 1;
 }

//GUIDE: must be named app and MUST be no_mangle
#[no_mangle]
fn app() -> ()
{

    
    let mut log: &'static mut Log = big_nv!(LOGNV:Log = [0;BLOCK_SIZE as usize]);
    let mut log_count: &'static mut u16 = big_nv!(LOG_COUNTNV:u16 = 0);
    let mut log_sample_count: &'static mut u16 = big_nv!(LOG_SAMPLECOUNTNV:u16 = 0);
    

    let mut dict: &'static mut Dict = big_nv!(DICTNV:Dict = [Node{letter:0, sibling:0, child:0};DICT_SIZE as usize]);

    let mut node_count: &'static mut u16 = big_nv!(NODE_COUNTNV:u16 = 0);
    
    while 1 == 1 {

//	unsafe { gpioTwiddle();}

	for _cnt in 0..LOOP_IDX {
	    
	    init_dict(&mut dict, &mut node_count);
	    //dict.node_count = 255;
	    // Initialize the pointer into the dictionary to one of the root nodes
	    // Assume all streams start with a fixed prefix ('0'), to avoid having
	    // to letterize this out-of-band sample.
	    let mut letter:Letter = 0;

	    
	    let mut letter_idx:u16 = 0;
            let mut parent:Index = 0;
            //let mut child:Index = 0;
            let mut sample:Sample = 0;
            let mut prev_sample:Sample = 0;

	    *log_sample_count = 1; // count the initial sample (see above)
	    *log_count = 0; // init compressed counter
	    while 1 == 1 { //Note: this loop breaks -- it's not infinite
		let mut  child:Index = letter as Index; // relies on initialization of dict
		//LOG("compress: parent %u\r\n", child); // naming is odd due to loop
		
		if letter_idx == 0 {
		    let sample = acquire_sample(prev_sample);
		    prev_sample = sample;
		}
		//LOG("letter index: %u\r\n", letter_idx);
		letter_idx+=1;
		if letter_idx == NUM_LETTERS_IN_SAMPLE {
		    letter_idx = 0;
		}
		//do {
		let mut letter_idx_tmp:u16 = if letter_idx == 0 { NUM_LETTERS_IN_SAMPLE } else { letter_idx - 1}; 
		
		let mut letter_shift:u16 = LETTER_SIZE_BITS as u16 * letter_idx_tmp;
		letter = if letter_shift == 16 {0} else {sample & 0xFF};
		//LOG("letterize: sample %x letter %x (%u)\r\n",
		//		sample, letter, letter);
		
		*log_sample_count+=1;
		//unsafe{printf(b"atomic depth: %l\r\n\0".as_ptr(), atomic_depth as u32);}
		parent = child;
		child = find_child(letter, parent, dict);
	
		//LOG("child: %u\r\n", child);
                //}
		while child != NIL {
                
		    letter_idx_tmp = if letter_idx == 0 { NUM_LETTERS_IN_SAMPLE } else { letter_idx - 1}; 
		    
                    letter_shift = LETTER_SIZE_BITS as u16 * letter_idx_tmp;
		    letter = if letter_shift == 16 {0} else {sample & 0xFF};
		    //LOG("letterize: sample %x letter %x (%u)\r\n",
                    //		sample, letter, letter);
		    
                    *log_sample_count+=1;
		    //unsafe{printf(b"atomic depth: %l\r\n\0".as_ptr(), atomic_depth as u32);}
		    parent = child;
                    child = find_child(letter, parent, dict);
		}
		
		
		append_compressed(parent,log, log_count);
		add_node(letter, parent, dict, node_count);
		if *log_count == BLOCK_SIZE {
		
		    print_log(&log, log_count, log_sample_count);
		   // while(1==1){
	//		print_log(&log);
	//	    }
		    *log_count = 0;
		    *log_sample_count = 0;
		    break;
		}
		
	    }
	}
	//atomic_start();
	unsafe {gpioTwiddle();}
	unsafe {gpioTwiddle();}
	//atomic_end();
	//enough time?
	//while 1==1{}
        //where defined?
	//end_run();
    }
    //return 0;
}
