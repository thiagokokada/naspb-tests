#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/../common_omp.sh

for class in A B C; do
  run_bench lu "${class}" 20
  run_bench sp "${class}" 20
  run_bench bt "${class}" 20
done

run_bench lu D 5
run_bench sp D 5
run_bench bt D 5

source ${DIR}/../email_setup.sh
python2 ${DIR}/../send_email.py -s "${SENDER_EMAIL}" -w "${SENDER_PASSWORD}" -m "${SMTP_SERVER}" "NASPB-OMP finished" "At `date`, NASPB-OMP benchmarks finished to run in `hostname`."
