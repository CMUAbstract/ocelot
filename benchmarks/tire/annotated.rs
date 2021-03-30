
#![no_std]
#![feature(core_panic)]
#![feature(const_in_array_repeat_expressions)]

include!("intermittent.rs");
#[no_mangle]
pub extern "C" fn _entry() {
    app();
}

extern {
    fn sqrt16(val:u32) -> u16;
    fn gpioTwiddle() -> ();

}

pub static IO_NAME:fn(u16) -> kPa = readPressure;
pub static IO_NAME2:fn(u16) -> u8 = readAccel;
pub static IO_NAME3:fn(u16, &u16) -> u16 = readTemp;

const PRESSURE_WINDOW_SIZE:usize = 5;

// Times to loop in one experiment
const LOOP_IDX:u16 = 264;

const ABS_PRESS_COEF:u16 = 2;

const BURST_THRESHOLD:u16 = 25;
//based on Nissan Rogue numbers, ideal is 33 psi/228~ kpa
const LOW_PRESSURE_WARNING:u16 = 200;
//sea level pressure, rounded down to int
const ATMOS:u16 = 101;


type pressureReading = u16;
type kPa = u16;
type pressureWindow = [pressureReading; PRESSURE_WINDOW_SIZE as usize];

struct History {
    meanPress: kPa,
    recentPressure: pressureWindow,
    lastPressure:pressureReading,
    lastDiff: kPa
}

//accel Types, needed to get if the vehicle is stationary or moving
const ACCEL_WINDOW_SIZE:usize = 3;
struct threeAxis{
    x:u8,
    y:u8,
    z:u8,
}
type accelReading = threeAxis;
type accelWindow = [accelReading; ACCEL_WINDOW_SIZE as usize];
const SAMPLE_NOISE_FLOOR:u8 = 10; // TODO: made up value


/* Globals */

/*simulated input input Functions*/
//pressure is always between atomspheric and 450
#[no_mangle]
fn readPressure(input:u16) -> kPa 
{
    let res = if input % 450 > ATMOS {input % 450} else {input % 450 + ATMOS};
    return res;
}

//simulated input function
#[no_mangle]
fn readAccel(input:u16) -> u8 
{
    return (input % 85) as u8;
}

//simulated input  function
#[no_mangle]
fn readTemp(sensor:u16,input:&u16) -> u16 
{
    match sensor {
        1 => /*Tire Temp*/ (32+(*input % 68) + (*input % 200))%255, 
        _ => /*Ambient Temp*/ 32+(*input % 68), 
    } 
}


/*Sampling and Adjusting Functions*/
/*get sample and adjust to relative pressure*/
fn relativePressure(seed:&u16) -> pressureReading
{
    let sample = readPressure(seed*17 - seed%17);
    return sample;
}

//based on the equation on page 12 here: 
//https://crashstats.nhtsa.dot.gov/Api/Public/ViewPublication/811681
fn coldPressure(input:pressureReading, seed:& mut u16) -> pressureReading
{
    let tempTire = readTemp(1, seed);
    let tempAmbient = readTemp(2, seed); 
    *seed+=1;
    let result = input - ((tempTire - tempAmbient)/10);
    
    result
}

/*Based on Activity Recognition*/
fn accelSample(seed:&u16) -> threeAxis
{
    //Inferred region for consistent set five starts here
    let xs = readAccel(seed*8);
    Consistent(xs,5);
    let ys = readAccel(seed*8*8);
    Consistent(ys,5);
    let zs = readAccel(seed*8*8*8);
    Consistent(zs,5);
    //Inferred region for consistent set five ends here
    let result: threeAxis = threeAxis{x:xs, y:ys, z:zs};
    return result;
}

fn acquireWindow(seed:& mut u16) -> accelWindow
{
    //accelReading sample;
    let mut window:accelWindow= [accelReading{x:0,y:0, z:0},
                 accelReading{x:0,y:0, z:0},accelReading{x:0,y:0, z:0}];
   for i in 0..ACCEL_WINDOW_SIZE {
        let mut sample: accelReading = accelSample(seed);
        sample.x = if sample.x > SAMPLE_NOISE_FLOOR {sample.x} else {0};
        sample.y = if sample.y > SAMPLE_NOISE_FLOOR {sample.y} else {0};
        sample.z = if sample.z > SAMPLE_NOISE_FLOOR {sample.z} else {0};
        window[i] = sample;
        //only increase it sometimes, so we get a mixture of stat. and mov.
        if *seed%5 == 0 {
            *seed+=1;
        }

    }
    return window;
}

fn isMoving(aWin:&accelWindow) -> bool
{
    //check if the readings are the same, with some margin of error
    let mut x = aWin[0].x;
    let mut y = aWin[0].y;
    let mut z = aWin[0].z;
    let mut likelyMoving = 0;
    let mut likelyStopped = 0;
    for i in 1..ACCEL_WINDOW_SIZE {
        if x <= aWin[i].x + SAMPLE_NOISE_FLOOR {
            likelyStopped +=1
        } else {
            likelyMoving+=1;
        }
        x = aWin[i].x;

        if y <= aWin[i].y + SAMPLE_NOISE_FLOOR {
            likelyStopped +=1
        } else {
            likelyMoving+=1;
        }
        y = aWin[i].y;

        if z <= aWin[i].z + SAMPLE_NOISE_FLOOR {
            likelyStopped +=1
        } else {
            likelyMoving+=1;
        }
        z = aWin[i].z;
    }

    if likelyMoving > likelyStopped {
        true
    } else {
        false
    }
}

//Now pressure functions
fn updateHistorical(data:&mut History, newReading:kPa)
{
    let mut mean = 0;
    data.lastDiff = if data.lastPressure > newReading 
    { data.lastPressure - newReading} else {0};
    data.lastPressure = newReading;

    //shift the recent readings window
    for i in 1..PRESSURE_WINDOW_SIZE {
        data.recentPressure[i] = data.recentPressure[i - 1];
        mean += data.recentPressure[i - 1];
    }
    data.recentPressure[0] = newReading;
    mean += newReading;
    mean /= PRESSURE_WINDOW_SIZE as u16;
    data.meanPress = mean;
}

fn sendData(data:&str) -> ()
{
    //unsafe{ delay(30000)};
    //manually guard output
    unsafe{start_atomic();}
    unsafe{printf(data.as_bytes().as_ptr());}
    unsafe{end_atomic();}
    //println!("{}",data);
}

fn end_of_benchmark(urgent:&u16, medium:&u16) -> ()
{
    unsafe {
    start_atomic();
    //manually guard output
    printf(b"Urgent: %l Medium: %l\n\0".as_ptr(),
    *urgent as u32, *medium as u32);
    end_atomic();
    }
    //println!("This is the end of the Tire benchmark {}  {}\n\0", *urgent, *medium);
}

fn initRecord(rec:&mut History, seed:& mut u16){
    let mut mean = 0;
    

    //shift the recent readings window
    for i in 0..PRESSURE_WINDOW_SIZE {
        let reading = relativePressure(seed);
        let adjusted = coldPressure(reading, seed);
        rec.recentPressure[i] = adjusted;
        mean += adjusted;
    }
    rec.lastDiff = if rec.recentPressure[1] > rec.recentPressure[0] 
    {rec.recentPressure[1] - rec.recentPressure[0]} else {0};
    rec.lastPressure = rec.recentPressure[0];
    mean /= PRESSURE_WINDOW_SIZE as u16;
    rec.meanPress = mean;

}


#[no_mangle]
fn app() -> ()
{
    let warningCount: &'static mut u16 = big_nv!(COUNT_NV: u16 = 0);
    let mediumWarningCount: &'static mut u16 = big_nv!(MWC_NV: u16 = 0);
    let urgentWarningCount: &'static mut u16 = big_nv!(UWC_NV: u16 = 0);
    let record: &'static mut History =
	big_nv!(HIST_NV:History = History{meanPress:0, recentPressure:[0;PRESSURE_WINDOW_SIZE],
        lastPressure:0, lastDiff:0});
    //nv!(model, model_t);
     let nv_seed: &'static mut u16 = big_nv!(SEED_NV: u16 = 1);
    
    //init();
    
    //count = 1;
    while 1 == 1 {
	*urgentWarningCount = 0;
	*mediumWarningCount = 0;
	*warningCount = 0;
	*nv_seed = 0;

        initRecord(record, nv_seed);
        
        //arbitrary idx for experiment length
        for i in 0..LOOP_IDX {
            //first get the accel data
            
            let window:accelWindow  = acquireWindow(nv_seed);
            if isMoving(&window) == false {
                //only sample every third time if the vehicle is stopped
                if i%3 != 0 {
                    continue;
                }

            } 
            //Inferred region for Fresh var 'reading' starts here
            let reading = relativePressure(nv_seed);
            Fresh(reading);
            let adjusted = coldPressure(reading, nv_seed);
            //Inferred region for var 'reading' ends here

            updateHistorical(record, adjusted);
            //possible burst tire, because of a sudden large decrease
            if record.lastDiff > BURST_THRESHOLD {
            //get a series of fresh and consistent readings, to check that 
            //it's a burst tire, not just, eg. a cold day
                //Outer-most inferred region for the fresh and consistent annotations
                // at lines 297 and 299 begins here
                let reading0 = relativePressure(nv_seed);

		        let reading1 = relativePressure(nv_seed);

		        let sumDiff = if reading0 < record.lastDiff 
                {record.lastDiff - reading0} else {0} + 
                if reading1 < reading0 {reading0 - reading1} else {0};

                let avgDiff = sumDiff/2;
                FreshConsistent(avgDiff,1);
                let currMotion:accelWindow = acquireWindow(nv_seed); 
                FreshConsistent(&currMotion,1);
                //car is moving and the pressure is actively decreasing
                if isMoving(&currMotion)  {
                    if avgDiff > 0 {
                    sendData("urgent_burst_tire!\r\n\0");
                    *urgentWarningCount +=1;
                    }
                    
                } 
                //Outermost Inferred region for the Fresh and consistent set 1 ends here
                //looking at the LLVM-IR, there will also be two inner inferred region, 
                //which were generated by inferrence for the freshness constraints

            }

            //otherwise, just check for low pressure
            else if record.meanPress < LOW_PRESSURE_WARNING {
                //send a warning 
                *warningCount += 1;
                if *warningCount > 1000 {
                    // if it's already been warned a lot, send a more urgent warning
                    sendData("urgent_low_pressure\r\n\0");
                    *urgentWarningCount +=1;
                } else {
                    sendData("medium_low_pressure\r\n\0");
                    *mediumWarningCount +=1;
                }
            }

            //otoh, if the diff is 0 (pressure has increased)
            //reinit the window, as the tire has gotten refilled
            //and the old data isn't valid anymore
            if record.lastDiff == 0 {
                initRecord(record, nv_seed);
                *warningCount = 0;
            } 

            
        }
        //end of benchmark
        end_of_benchmark(urgentWarningCount, mediumWarningCount);
        unsafe{
		gpioTwiddle();
        gpioTwiddle();
        }
	    
	}
	
}
