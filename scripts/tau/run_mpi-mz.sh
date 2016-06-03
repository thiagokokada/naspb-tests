#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/../common_mpi.sh

NUMBER_OF_PROCESS=2
THREADS_PER_PROCESS=16
export OMP_NUM_THREADS="${THREADS_PER_PROCESS}"

run_bench() {
  local bench="${1}"
  local class="${2}"
  local nprocs="${3}"
  local hostfile="hostfile.txt"
  local interval="10"
  local name="${bench}.${class}.${nprocs}"

  mpirun -np "${nprocs}" -hostfile "${hostfile}" -x OMP_NUM_THREADS "${name}"
  tar cfJ "${name}.tar.xz" profile.*
  rm -rf profile.*
  sleep "${interval}"
}

for class in A B C D; do
  run_bench lu "${class}" "${NUMBER_OF_PROCESS}"
  run_bench sp "${class}" "${NUMBER_OF_PROCESS}"
  run_bench bt "${class}" "${NUMBER_OF_PROCESS}"
done

source ${DIR}/../email_setup.sh
python2 ${DIR}/../send_email.py -s "${SENDER_EMAIL}" -w "${SENDER_PASSWORD}" -m "${SMTP_SERVER}" "NASPB-MZ-MPI-TAU finished" "At `date`, NASPB-MZ-MPI-TAU benchmarks finished to run in `hostname`."
