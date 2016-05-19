#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/../common_omp.sh

for class in A B C D; do
  compile_bench lu-mz "${class}"
  compile_bench sp-mz "${class}"
  compile_bench bt-mz "${class}"
done
