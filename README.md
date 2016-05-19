# naspb-tests

## NAS Parallel Benchmarks results in different environments

### Introduction

Scripts to run [NAS Parallel Benchmarks](http://www.nas.nasa.gov/publications/npb.html) in multi-node environments
(Beowulf cluster, cloud, etc.).

### How to use

Firstly, run `scripts/setup.sh` to install the dependencies for Ubuntu 14.04. After that run `scripts/naspb.sh` to
download NPB source-code, extract and prepare the source to compilation.

To compile the benchmarks, go to the folder containing the desired benchmark (for example, `NPB-3.3.1/NPB-3.3-MPI` for
MPI benchmarks), and run the correct script to compile (for MPI, it is `scripts/mpi/compile.sh`). This will generate
the benchmarks in `<benchmark type>/bin` folder.

To run the benchmarks, go to the generated `bin` folder and run the correct run script (for MPI, it is
`scripts/mpi/run.sh`). Probably you will want to look up the script first, to correct the number of instances, sizes
and repetitions. For MPI benchmarks you need to generate write a `hostfile.txt` file too, inside `bin` folder.

### License

This code is licensed in MIT license. See [this link](https://opensource.org/licenses/MIT) for details.
