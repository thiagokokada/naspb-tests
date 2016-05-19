#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/../common_mpi.sh

NUMBER_OF_PROCESS=2
THREADS_PER_PROCESS=16

export OMP_NUM_THREADS="${THREADS_PER_PROCESS}"
for class in A B C; do
  run_bench lu-mz "${class}" "${NUMBER_OF_PROCESS}" 20
  run_bench sp-mz "${class}" "${NUMBER_OF_PROCESS}" 20
  run_bench bt-mz "${class}" "${NUMBER_OF_PROCESS}" 20
done

run_bench lu-mz D "${NUMBER_OF_PROCESS}" 5
run_bench sp-mz D "${NUMBER_OF_PROCESS}" 5
run_bench bt-mz D "${NUMBER_OF_PROCESS}" 5

source ${DIR}/../email_setup.sh
python2 ${DIR}/../send_email.py -s "${SENDER_EMAIL}" -w "${SENDER_PASSWORD}" -m "${SMTP_SERVER}" "NASPB-MZ-MPI finished" "At `date`, NASPB-MZ-MPI benchmarks finished to run in `hostname`."
