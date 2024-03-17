include!("../intermittent.rs");

#[no_mangle]
fn tmp() -> i32 {
    0
}

#[no_mangle]
pub static IO_NAME: fn() -> i32 = tmp;

#[no_mangle]
fn log(i: i32) -> () {}

#[no_mangle]
fn app() -> () {
    let x = tmp();
    Fresh(x);
    log(x)
}

fn main() -> () {
    app()
}
