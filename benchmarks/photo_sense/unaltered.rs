#![no_std]
#![feature(core_panic)]
//#![no_builtins]
//GUIDE: import the file with the intermittent macros, structs, etc.
include!("intermittent.rs");
//GUIDE: put c driver funcs, etc., in here
extern {
//    fn read_light() -> u16;
    //maybe todo: move the latter into intermittent.rs, so any app will have them as utility funcs, like printf
    fn gpioUp() -> ();
    fn gpioDown() -> ();
    fn gpioTwiddle() -> ();
	fn delay(time:u32) -> ();
    fn checkpoint() -> ();
    fn restore_vol() -> ();
    fn msp_sleep(time:u16) -> ();
}
//GUIDE: IO op annotations as pub static function pointer
#[no_mangle]
pub static IO_NAME : fn(count:u16) -> u16 =  read_light;

fn read_light (count:u16) -> u16
{
    //spend a little time, because orig photo resistor was expensive
    let mut val = count;
    for _i in 0..50{
	val+=1;
    }
    //typical room level
    return 1400 + (val % 17)
}
 
//#[no_mangle]
//pub static IO_NAME : unsafe extern "C" fn() -> u16 =  read_light;

//NOTE TO SELF:This is neessary! It causes everything to be visible to C (TODO make cleaner)
#[no_mangle]
pub extern "C" fn _entry() {
    app();
}

//GUIDE: and now write the app in rust normally
const WINDOW_SIZE:u16 = 3;

fn  average_light(count:u16) -> u16 {
	let mut light:u16 = unsafe{read_light(count)};
	for _i in 1..WINDOW_SIZE {
            light += unsafe{read_light(count + _i)};
	   // light += unsafe{read_light()};
        //TODO: where is this defined

	    //unsafe{msp_sleep(10);}
	}
	light /= WINDOW_SIZE;
	return light;
}

//GUIDE: what would be 'main' must be named 'app' and must be no mangle
#[no_mangle]
fn app() -> ()
{
	/*MILIJANA: this stuff is handled in main.c, not rustland*/
	//chkpt_mask_init = 1; // TODO: for now, special case for init ( But do we need this at all? )
	//init();
	//restore_regs();
	//chkpt_mask_init = 0;

    while 1 ==1 {
	for i in 0..100 {
	    //PROTECT_BEGIN();
	    //unsafe { printf(b"start\r\n\0".as_ptr());}
	    //PROTECT_END();
	    
            //PROTECT_BEGIN();
	    let light = average_light(i);
	    
	    unsafe{
		//start_atomic();
		//printf(b"end %l\r\n\0".as_ptr(), light as u32);
		//end_atomic();
	    }
	    
	    //PROTECT_END();
	}
	unsafe{ start_atomic();}
	unsafe{gpioTwiddle();}
        unsafe{gpioTwiddle();}
	unsafe{end_atomic();}
    }

}
