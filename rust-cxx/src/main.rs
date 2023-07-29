use std::ffi::CString;
use std::ffi::CStr;
use std::ffi::c_char;

#[cxx::bridge]
mod ffi {
    unsafe extern "C++" {
        include!("rust-cxx/src/NativeStuff.h");

        unsafe fn say_hello(name: *mut c_char) -> *mut c_char;
    }
}

fn to_c_char(str_to_convert: &str) -> *mut c_char {
    let c_string = CString::new(str_to_convert).expect("CString::new failed");
    let raw: *mut c_char = c_string.into_raw();
    raw
}

fn main() {
    let name = to_c_char("Interop");
    unsafe { 
        let greeting_ptr = ffi::say_hello(name);
        let greeting_c_str = CStr::from_ptr(greeting_ptr);
        if greeting_c_str.to_str() != Ok("Hello Interop!") {
            panic!("Program returned incorrect greeting!");
        }
    }
}
