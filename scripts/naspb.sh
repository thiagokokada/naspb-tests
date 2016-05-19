#!/bin/bash

# Download and extract NPB
wget http://www.nas.nasa.gov/assets/npb/NPB3.3.1.tar.gz 2>&1
tar xf NPB3.3.1.tar.gz
pushd NPB3.3.1
# Setup MPI
cd NPB3.3-MPI/config
cp suite.def.template suite.def
cp make.def.template make.def
sed -i -e 's/f77/mpif77/g' -e 's/cc/mpicc/g' -e 's/-O/-O3 -mcmodel=medium/g' make.def
cd ../..
# Setup OMP
cd NPB3.3-OMP/config
cp suite.def.template suite.def
cp NAS.samples/make.def.gcc_x86 make.def
cd ../..
# Setup Serial
cd NPB3.3-SER/config
cp suite.def.template suite.def
cp NAS.samples/make.def_gcc_x86 make.def
popd

# Download, extract and setup NPB-MZ
wget http://www.nas.nasa.gov/assets/npb/NPB3.3.1-MZ.tar.gz 2>&1
tar xf NPB3.3.1-MZ.tar.gz
pushd NPB3.3.1-MZ
cd NPB3.3-MZ-MPI/config
cp suite.def.template suite.def
cp make.def.template make.def
sed -i 's/-O/-O3 -mcmodel=medium -fopenmp/g' make.def
cd ../..
# Setup OMP
cd NPB3.3-MZ-OMP/config
cp suite.def.template suite.def
cp NAS.samples/make.def_gcc make.def
sed -i -e 's/g77/gfortran/g' -e 's/-O3/-O3 -mcmodel=medium -fopenmp/g' make.def
cd ../..
# Setup Serial
cd NPB3.3-MZ-SER/config
cp suite.def.template suite.def
cp NAS.samples/make.def_gcc make.def
popd
