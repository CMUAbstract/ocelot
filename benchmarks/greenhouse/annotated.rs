#![no_std]
#![feature(core_panic)]
#![feature(const_in_array_repeat_expressions)]
//#![no_builtins]
//GUIDE: import the file with the intermittent macros, structs, etc.
include!("intermittent.rs");
//GUIDE: put c driver funcs, etc., in here
extern {
//    fn adcConfig() -> u16;
  //  fn adcSample() -> u16;
   // fn tempConfig() -> u16;
    //fn tempDegC() -> f32;
    fn gpioUp() -> ();
    fn gpioDown() -> ();
    fn gpioTwiddle() -> ();
    fn gpioOneTwiddle() -> ();
    fn delay(time:u32) -> ();
}
//GUIDE: IO op annotations as pub static function pointer
#[no_mangle]
pub static IO_NAME :  /*unsafe extern "C"*/ fn() -> u16 =  adcConfig;
#[no_mangle]
pub static IO_NAME2 : /*unsafe extern "C"*/   fn(u16) -> u16 =  adcSample;
#[no_mangle]
pub static IO_NAME3 : /*unsafe extern "C"*/   fn() -> u16 =  tempConfig;
#[no_mangle]
pub static IO_NAME4 : /*unsafe extern "C"*/  fn(u16) -> f32 =  tempDegC;

fn adcConfig () -> u16
{
    //basically no-op without a sensor, but make it take a few cycles
    let mut reg = 0;
    for _i in 0..40 {
	reg+=1;
    }
    return 0;
}

fn tempConfig () -> u16
{
    //basically no-op without a sensor, but make it take a few cycles
    let mut reg = 0;
    for _i in 0..40 {
	reg+=1;
    }
    return 0;
}

fn adcSample (count:u16) -> u16
{
    //use printf as it is expensive, like sensor
    unsafe{
    start_atomic();
    printf(b"adc\r\n\0".as_ptr());
	end_atomic();}
    return 1000 + (count % 17)
}

fn tempDegC (count:u16) -> f32
{
    //use printf as it is expensive, like sensor
    unsafe{
    start_atomic();
    printf(b"temp\r\n\0".as_ptr());
	end_atomic();
    }
    return 4.7 + count as f32;
}

//GUIDE:This is neessary! It causes everything to be visible to C (TODO make cleaner)
#[no_mangle]
pub extern "C" fn _entry() {
    app();
}

//GUIDE: and now write the app in rust normally

pub const SAMPLE_SIZE:usize  = 5;

struct Tuple {
    m:u16,
    t:f32,
}


fn calcAvg(moisture:&[u16], temperature:&[f32]) -> Tuple
{
    let mut avg:Tuple = Tuple{m:0, t:0.0};
    for i in 0..SAMPLE_SIZE
    {
        avg.m += moisture[i];
        avg.t = avg.t + temperature[i];
    }
    avg.m = avg.m/(SAMPLE_SIZE as u16);
    avg.t = avg.t/(SAMPLE_SIZE as f32);
    return avg;
}

fn storeData(m:u16, t:f32, moisture:&mut [u16], temperature:&mut [f32]) -> ()
{
    for i in 1..SAMPLE_SIZE
    {
        moisture[i] = moisture[i-1];
        temperature[i] = temperature[i-1];
    }
    moisture[0] = m;
    temperature[0] = t;
}

fn compute(avg:&Tuple) -> ()
{
    //ledConfig();
    if avg.t > 10.0 && avg.t < 22.0
    {
        unsafe{gpioOneTwiddle()};
    }
    else if avg.t >= 22.0
    {
        unsafe{gpioOneTwiddle()};
        unsafe{gpioOneTwiddle()};
    }
    else
    {
        unsafe{gpioOneTwiddle()};
        unsafe{gpioOneTwiddle()};
        unsafe{gpioOneTwiddle()};
    }

}

fn sendData(data:&Tuple) -> ()
{
    //unsafe{ delay(30000)};
    //mimic the delay... function doesn't compile properly with clang  
    let mut i:u16 = 0;
    while i < 3000 {
	i+=1;
    }
}

//GUIDE: what would be main must be titled 'app'
#[no_mangle]
fn app() -> ()
{
    //old globs
    let senseCount1:&'static mut u8 = big_nv!(SENSE1:u8 = 0);
    let senseCount2:&'static mut u8 = big_nv!(SENSE2:u8 = 0);
    let computeCount:&'static mut u8 = big_nv!(COMPUTEC:u8 = 0);
    let sendCount:&'static mut u8 = big_nv!(SENDC:u8 = 0);

    let moisture:&'static mut[u16;SAMPLE_SIZE] = big_nv!(MOISTURE:[u16;SAMPLE_SIZE] = [0,0,0,0,0]);
    let temperature:&'static mut[f32;SAMPLE_SIZE] = big_nv!(TEMPERATURE:[f32;SAMPLE_SIZE] = [0.0,0.0,0.0,0.0,0.0]);
    let moist:&'static mut u16 = big_nv!(MOIST:u16 = 0);
    let temp:&'static mut f32 = big_nv!(TEMP:f32 = 0.0);
    let moistTempAvg:&'static mut Tuple = big_nv!(AVG:Tuple = Tuple{m:0, t:0.0});
    //end old

    while 1== 1
    {
        //platformInit();
        //if(P8IN & 0x02)
        for _i in 0..40
        {
            // checkpoint
        //Inferred region for Consistent set 1 starts here
	    let init =  unsafe {adcConfig()};
	    Consistent(init,1);
	    *moist = unsafe {adcSample(_i)};
        *senseCount1+=1;

        let init2 = unsafe{tempConfig()};
	    Consistent(init2, 1);
	    *temp = unsafe{tempDegC(_i)};
        //inferred region ends here, even though 
        //there is another declaration in the set yet to come, on line 183
        *senseCount2+=1;

        // checkpoint
	    storeData(*moist, *temp, moisture, temperature);

        // checkpoint
	    let moistTempAvgLocal = calcAvg(moisture, temperature);
	    Consistent(&moistTempAvgLocal, 1);
        //note that this declaration does not need to be in the region, 
        //since no lines of code from 174 to here sample inputs
	    
	    moistTempAvg.m = moistTempAvgLocal.m;
            moistTempAvg.t = moistTempAvgLocal.t;
            /*unsafe {
		start_atomic();
                printf(b"Moisture: %l Moist avg.:%l Temp: %l MoistTempAvg: %l overflow %l %l %l \n\r\0".as_ptr(),
                       *moist as u32, moistTempAvg.m as u32, *temp as f64, moistTempAvg.t as f64, 0, 0, 0);
		end_atomic();
            }*/
            compute(moistTempAvg);
            *computeCount+=1;

            // checkpoint
	    
            sendData(moistTempAvg);
            *sendCount+=1;

            // checkpoint
	    //delay(5);
        }
	unsafe{
	    /*start_atomic();
	    unsafe{printf(b"clear buff\r\n\0".as_ptr());}
            unsafe {
		printf(b"Counts: SenseOne:%l SenseTwo: %l Compute: %l Send: %l\n\r\0".as_ptr(),
                       *senseCount1 as u32, *senseCount2 as u32, *computeCount as u32, *sendCount as u32);
            }
	    end_atomic();*/
	    unsafe{gpioTwiddle()};
            unsafe{gpioTwiddle()};
	}
	*senseCount1 = 0;
	*senseCount2 = 0;
	*computeCount = 0;
	*sendCount = 0;
        //while 1==1{};
    }
}

