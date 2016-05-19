#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/../common_omp.sh

for class in A B C; do
  run_bench lu-mz "${class}" 20
  run_bench sp-mz "${class}" 20
  run_bench bt-mz "${class}" 20
done

run_bench lu-mz D 5
run_bench sp-mz D 5
run_bench bt-mz D 5

source ${DIR}/../email_setup.sh
python2 ${DIR}/../send_email.py -s "${SENDER_EMAIL}" -w "${SENDER_PASSWORD}" -m "${SMTP_SERVER}" "NASPB-MZ-OMP finished" "At `date`, NASPB-MZ-OMP benchmarks finished to run in `hostname`."
