fn main() {
    cxx_build::bridge("src/main.rs")
        .file("src/NativeStuff.cc")
        .flag_if_supported("-std=c++14")
        .compile("rust-cxx");
}