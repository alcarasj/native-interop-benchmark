# native-interop-benchmark
Benchmarking of various native interop methods using [hyperfine](https://github.com/sharkdp/hyperfine).

## Setup
Requires an Ubuntu 23.04 ARM64 machine.
1. Open a terminal window and `cd` to repo root.
2. Install `make` with `sudo apt install -y make`
3. Install the prerequisites with `make setup-prereqs-ubuntu`
4. Compile and run the benchmarks with `make prepare-and-benchmark`

## Results
Running on an Ubuntu 23.04 ARM64 VM on Azure using the Standard D2pls v5 SKU (2 vCPUs, 4GiB RAM)
<img width="1083" alt="image" src="https://github.com/alcarasj/native-interop-benchmark/assets/15123646/ae5c763e-1f6e-46ce-a643-061ea8d28b3f">
