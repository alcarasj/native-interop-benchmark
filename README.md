# native-interop-benchmark
Benchmarking of various native interop methods using [hyperfine](https://github.com/sharkdp/hyperfine).

## Setup
Requires an Ubuntu 23.04 ARM64 machine.
1. Open a terminal window and `cd` to repo root.
2. Install `make` with `sudo apt install -y make`
3. Install the prerequisites with `make setup-prereqs-ubuntu`
4. Compile and run the benchmarks with `make prepare-and-benchmark`