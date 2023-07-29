setup-prereqs-ubuntu:
	sudo apt update
	sudo apt install -y build-essential clang zlib1g-dev dotnet-sdk-6.0 dotnet-sdk-7.0 hyperfine 

compile-native:
	g++ -shared -fPIC ./native/NativeStuff.cc -o ./native/NativeStuff.so
	g++ ./native/Main.cc -o ./native/Main

compile-dotnet6-pinvoke:
	make compile-native
	dotnet publish ./dotnet6-pinvoke/DotNet6PInvoke.csproj -c Release
	cp ./native/NativeStuff.so ./dotnet6-pinvoke/bin/Release/net6.0/NativeStuff.so

compile-dotnet7aot-pinvoke:
	make compile-native
	dotnet publish ./dotnet7aot-pinvoke/DotNet7AotPInvoke.csproj -c Release
	cp ./native/NativeStuff.so ./dotnet7aot-pinvoke/bin/Release/net7.0/linux-arm64/publish/NativeStuff.so

benchmark:
	make compile-native
	make compile-dotnet6-pinvoke
	make compile-dotnet7aot-pinvoke
	hyperfine --show-output --warmup 5 --runs 10 './native/Main' 'dotnet ./dotnet6-pinvoke/bin/Release/net6.0/DotNet6PInvoke.dll' './dotnet7aot-pinvoke/bin/Release/net7.0/linux-arm64/publish/DotNet7AotPInvoke'