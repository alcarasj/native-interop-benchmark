package main

func sayHello(name string) string {
	return "Hello " + name + "!"
}

func main() {
	name := "Interop"
	greeting := sayHello(name)
	if greeting != "Hello Interop!" {
		panic("Program returned incorrect greeting!")
	}
}
