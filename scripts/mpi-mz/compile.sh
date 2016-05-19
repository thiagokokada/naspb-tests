#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/../common_mpi.sh

for class in A B C D; do
  for nprocs in 2 4 8 16; do
    compile_bench lu-mz "${nprocs}" "${class}"
    compile_bench sp-mz "${nprocs}" "${class}"
    compile_bench bt-mz "${nprocs}" "${class}"
  done
done
