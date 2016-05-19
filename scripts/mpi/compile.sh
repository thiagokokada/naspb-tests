#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/../common_mpi.sh

for class in A B C D; do
  compile_bench lu 32 "${class}"
  compile_bench sp 25 "${class}"
  compile_bench sp 36 "${class}"
  compile_bench bt 25 "${class}"
  compile_bench bt 36 "${class}"
done
