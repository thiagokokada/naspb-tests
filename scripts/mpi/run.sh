#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/../common_mpi.sh

for class in A B C; do
  run_bench lu "${class}" 32 20
  run_bench sp "${class}" 25 20
  run_bench sp "${class}" 36 20
  run_bench bt "${class}" 25 20
  run_bench bt "${class}" 36 20
done

run_bench lu D 32 5
run_bench sp D 25 5
run_bench sp D 36 5
run_bench bt D 25 5
run_bench bt D 36 5

source ${DIR}/../email_setup.sh
python2 ${DIR}/../send_email.py -s "${SENDER_EMAIL}" -w "${SENDER_PASSWORD}" -m "${SMTP_SERVER}" "NASPB-MPI finished" "At `date`, NASPB-MPI benchmarks finished to run in `hostname`."
