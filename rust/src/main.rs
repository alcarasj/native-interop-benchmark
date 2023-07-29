fn say_hello(name: &str) -> String {
    return format!("Hello {name}!", name=name)
}

fn main() {
    let name = "Interop";
    let greeting = say_hello(name);
    if greeting != "Hello Interop!" {
        panic!("Program returned incorrect greeting!");
    }
}
