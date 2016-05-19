#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/../common_omp.sh

for class in A B C D; do
  compile_bench lu "${class}"
  compile_bench sp "${class}"
  compile_bench bt "${class}"
done
