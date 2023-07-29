compile-native:
	g++ -shared -fPIC ./native/NativeStuff.cc -o ./native/NativeStuff.so
	g++ ./native/Main.cc -o ./native/Main

compile-dotnet6-pinvoke:
	make compile-native
	dotnet publish ./dotnet6-pinvoke/DotNet6PInvoke.csproj -c Release
	cp ./native/NativeStuff.so ./dotnet6-pinvoke/bin/Release/net6.0/NativeStuff.so

benchmark:
	make compile-native
	make compile-dotnet6-pinvoke
	hyperfine --show-output --warmup 5 --runs 10 './native/Main' 'dotnet ./dotnet6-pinvoke/bin/Release/net6.0/DotNet6PInvoke.dll' 