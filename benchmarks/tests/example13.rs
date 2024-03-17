include!("../intermittent.rs");

#[no_mangle]
fn input() -> i32 {
    0
}

#[no_mangle]
pub static IO_NAME: fn() -> i32 = input;

#[no_mangle]
fn log(i: i32) -> () {}

#[no_mangle]
fn app() -> () {
    let x = input();
    for i in x..10 {
        log(i);
    }
    Fresh(x);
}

fn main() -> () {
    app()
}
