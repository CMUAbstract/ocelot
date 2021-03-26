#![no_std]
#![feature(core_panic)]
//#![no_builtins]
//GUIDE: import the file with the intermittent macros, structs, etc.
include!("intermittent.rs");
//GUIDE: put c driver funcs, etc., in here
extern {
// use these when not in JIT mode on intermittent power
//    fn read_light() -> u16;
//    fn radio_on() -> ();
//    fn radio_off() -> ();
    fn uartlink_close() -> ();
    fn uartlink_open_tx()->();
    fn uartlink_send(buf:*const u8, len:u16) -> ();
    fn msp_sleep(time:u16) -> ();
    //maybe todo: move the latter into intermittent.rs, so any app will have them as utility funcs, like printf
    fn gpioUp() -> ();
    fn gpioDown() -> ();
    fn gpioTwiddle() -> ();
}
//GUIDE: IO op annotations as pub static function pointer
#[no_mangle]
//pub static IO_NAME : unsafe extern "C" fn() -> u16 =  read_light;
pub static IO_NAME1 :  unsafe extern "C" fn() -> () =  radio_on;
pub static IO_NAME2 :  unsafe extern "C" fn() -> () =  radio_off;
#[no_mangle]
pub static IO_NAME : fn(count:u16) -> u16 =  read_light;

//simulated sensors to enable execution in JIT mode on intermittent power
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

//sensor init is kind of no-op without sensor. just make it take a little time
///*
fn radio_on () -> ()
{
    //spend a little time, because orig photo resistor was expensive
    let mut val = 0;
    for _i in 0..50{
	val+=1;
    }
    
}

fn radio_off () -> ()
{
    //spend a little time, because orig photo resistor was expensive
    let mut val = 0;
    for _i in 0..50{
	val+=1;
    }
    
}
//*/
//GUIDE:This is neessary! It causes everything to be visible to C (TODO make cleaner)
#[no_mangle]
pub extern "C" fn _entry() {
    app();
}

const RADIO_PAYLOAD_LEN:usize = 1;
const RADIO_BOOT_CYCLES:u16 =  60;

const RADIO_CMD_SET_ADV_PAYLOAD:u8 = 0;

struct RadioPkt{
    cmd:u8,
    payload:[u8;RADIO_PAYLOAD_LEN],
}

//TODO: confirm that capy init does indeed initialize the radio pins
fn sense_and_send(count:u16) -> ()
{
    //Inferred region for Fresh var 'light' begins here
    let light:u16 = unsafe {read_light(count)};
    Fresh(light);
   // unsafe{start_atomic();}
    //unsafe{printf(b"light: %l\r\n\0".as_ptr(), light as u32);}
    //unsafe{end_atomic();}
    if light > 4000 {
        unsafe{start_atomic();}
        unsafe{printf(b"send ble\r\n\0".as_ptr());}
        unsafe{end_atomic();}
        let packet:RadioPkt = RadioPkt{cmd:RADIO_CMD_SET_ADV_PAYLOAD,payload:[0x77]};
            unsafe{radio_on();}
        //unsafe{printf(b"sending... %s\r\n\0".as_ptr(), [packet.cmd,packet.payload[0]].as_ptr());}

        unsafe{msp_sleep(RADIO_BOOT_CYCLES);} // ~15ms @ ACLK/8
        
        unsafe{uartlink_open_tx();}
        // send size + 1 (size of packet.cmd)
        unsafe{uartlink_send([packet.cmd,packet.payload[0]].as_ptr(), RADIO_PAYLOAD_LEN as u16+1 );}
        unsafe{uartlink_close();}

        // Heuristic number based on experiment
        unsafe{msp_sleep(30*(RADIO_PAYLOAD_LEN as u16));}
        
        unsafe{radio_off();}
    }
    //inferered region for Fresh light ends here, after the branch on line 88
    
}	

#[no_mangle]
fn app() -> ()
{
    while 1==1 {	
	let mut count:u16 = 0;
	
	for _i in 0..100 {
            //PROTECT_BEGIN();
	//    unsafe{ start_atomic();
	//	    printf(b"start\r\n\0".as_ptr());
	//	    end_atomic();}
	    //	PROTECT_END();
	    
	    
	    //PROTECT_BEGIN();
	    sense_and_send(count);
	    //PROTECT_END();
	    // translated code end
	    
	    //PROTECT_BEGIN();
	    //unsafe{start_atomic();
	    //printf(b"end %l\r\n\0".as_ptr(), count as u32);
	    //end_atomic();}
	    //PROTECT_END();
	    count+=1;
	}
	unsafe{gpioTwiddle();}
	unsafe{gpioTwiddle();}
	
    }

}
