#!/bin/bash

wget http://tau.uoregon.edu/tau.tgz
tar xf tau.tgz
pushd tau-*
TAU_PATH=`pwd`
./configure -mpi -openmp
make install
popd

echo "export PATH=$TAU_PATH/x86_64/bin:$PDT_PATH/x86_x64/bin:$PATH" > tau_path.sh
