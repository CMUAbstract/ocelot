//#![no_std]
//#![feature(core_panic)]
//#![feature(const_in_array_repeat_expressions)]
// extern crate panic_msp430;
extern "C" {
    fn start_atomic();
    fn end_atomic();
    //add any externs, as from drivers, here
    fn printf(format: *const u8, ...);
    //necessary to import as the intrumentation pass needs to see this
    static mut atomic_depth: u16;
}

/*
#[no_mangle]
pub extern "C" fn _entry() {
    app();
}
*/
#[allow(dead_code)]
#[allow(non_snake_case)]
#[no_mangle]
fn Fresh<T>(_var: T) -> () {}

#[allow(dead_code)]
#[allow(non_snake_case)]
#[no_mangle]
fn Consistent<T>(_var: T, _id: u16) -> () {}

#[allow(dead_code)]
#[allow(non_snake_case)]
#[no_mangle]
fn FreshConsistent<T>(_var: T, _id: u16) -> () {}

//#[inline(always)]
#[no_mangle]
fn atomic_start() -> () {
    unsafe {
        // variable must be visible to the omega pass
        let local = atomic_depth;
        start_atomic();
    }
}
#[no_mangle]
fn atomic_end() -> () {
    unsafe {
        end_atomic();
    }
}

#[macro_export]
macro_rules! nv {
    ($name:ident : $ty:ty = $expr:expr) => {
        unsafe {
            #[link_section = ".nv_vars"]
            static mut $name: Option<$ty> = None;

            let used = $name.is_some();
            if used {
                None
            } else {
                $name = Some($expr);
                $name.as_mut()
            }
        }
    };
}

#[macro_export]
macro_rules! big_nv {
    ($name:ident : $ty:ty = $expr:expr) => {
        unsafe {
            #[link_section = ".nv_vars"]
            static mut $name: $ty = $expr;
            &mut $name
        }
    };
}
