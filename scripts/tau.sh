#!/bin/bash

wget http://tau.uoregon.edu/pdt.tgz
tar xf pdt.tgz
pushd pdtoolkit-*
PDT_PATH=`pwd`
./configure
make install
popd

wget http://tau.uoregon.edu/tau.tgz
tar xf tau.tgz
pushd tau-*
TAU_PATH=`pwd`
./configure -mpi -openmp -slog2 \
  -MPITRACE -PROFILE -TRACE \
  -pdt="${PDT_PATH}" \
  -mpiinc='/usr/include/openmpi' \
  -mpilib='/usr/lib/openmpi/lib'
make install
popd

echo "export PATH=$TAU_PATH/x86_64/bin:$PDT_PATH/x86_x64/bin:$PATH" > tau_path.sh
