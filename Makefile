# For running Makefile: make
# For compiling C++ (native): build-essential
# For compiling .NET 6 (dotnet6-pinvoke): dotnet-sdk-6.0
# For compiling .NET 7 (dotnet7aot-pinvoke): dotnet-sdk-7.0, clang, zlib1g-dev
# For compiling Rust (rust-cxx): cargo
# For running benchmark: hyperfine
setup-prereqs-ubuntu:
	sudo apt update
	sudo apt install -y make build-essential clang zlib1g-dev dotnet-sdk-6.0 dotnet-sdk-7.0 cargo hyperfine

compile-native:
	g++ -shared -fPIC ./native/NativeStuff.cc -o ./native/NativeStuff.so
	g++ ./native/Main.cc -o ./native/Main

compile-dotnet6:
	make compile-native
	dotnet publish ./dotnet6/DotNet6.csproj -c Release
	cp ./native/NativeStuff.so ./dotnet6/bin/Release/net6.0/NativeStuff.so

compile-dotnet6-pinvoke:
	make compile-native
	dotnet publish ./dotnet6-pinvoke/DotNet6PInvoke.csproj -c Release
	cp ./native/NativeStuff.so ./dotnet6-pinvoke/bin/Release/net6.0/NativeStuff.so

compile-dotnet7aot-pinvoke:
	make compile-native
	dotnet publish ./dotnet7aot-pinvoke/DotNet7AotPInvoke.csproj -c Release
	cp ./native/NativeStuff.so ./dotnet7aot-pinvoke/bin/Release/net7.0/linux-arm64/publish/NativeStuff.so

compile-rust-cxx:
	cp ./native/NativeStuff.cc ./rust-cxx/src/NativeStuff.cc
	cp ./native/NativeStuff.h ./rust-cxx/src/NativeStuff.h
	cd rust-cxx && cargo build --release
	cd ..
	rm ./rust-cxx/src/NativeStuff.*

compile-all:
	make compile-native
	make compile-dotnet6
	make compile-dotnet6-pinvoke
	make compile-dotnet7aot-pinvoke
	make compile-rust-cxx

prepare-and-benchmark:
	make compile-all
	make benchmark

benchmark:
	hyperfine --show-output --warmup 5 --runs 100 './native/Main' 'dotnet ./dotnet6/bin/Release/net6.0/DotNet6.dll' 'dotnet ./dotnet6-pinvoke/bin/Release/net6.0/DotNet6PInvoke.dll' './dotnet7aot-pinvoke/bin/Release/net7.0/linux-arm64/publish/DotNet7AotPInvoke' './rust-cxx/target/release/rust-cxx'