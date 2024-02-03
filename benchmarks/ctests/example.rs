fn Fresh<T>(_var: T) -> () {}

fn Consistent<T>(_var: T, _id: u16) -> () {}

#[no_mangle]
pub static IO_NAME: fn() -> i32 = tmp;

#[no_mangle]
fn tmp() -> i32 {
    0
}

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
