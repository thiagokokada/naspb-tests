#!/bin/bash

wget http://tau.uoregon.edu/pdt.tgz
tar xf pdt.tgz
pushd pdtoolkit-*
TAU_PATH=`pwd`
./configure
make install
popd

wget http://tau.uoregon.edu/tau.tgz
tar xf tau.tgz
pushd tau-*
./configure -cc=mpicc -c++=mpiCC -fortran=mpif77 -useropt='-O3 -mcmodel=medium' \
  -mpi -openmp \
  -MPITRACE -PROFILE -TRACE \
  -pdt="${TAU_PATH}" \
  -mpiinc='/usr/include/openmpi' \
  -mpilib='/usr/lib/openmpi/lib'
make install
popd
