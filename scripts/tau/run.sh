#!/bin/bash

run_bench() {
  local bench="${1}"
  local class="${2}"
  local nprocs="${3}"
  local hostfile="hostfile.txt"
  local interval="10"
  local name="${bench}.${class}.${nprocs}"

  mpirun -np "${nprocs}" -hostfile "${hostfile}" "${name}"
  tar cfJ "${name}.tar.xz" profile.*
  rm -rf profile.*
  sleep "${interval}"
}

for class in A B C D; do
  run_bench lu "${class}" 32
  run_bench sp "${class}" 25
  run_bench sp "${class}" 36
  run_bench bt "${class}" 25
  run_bench bt "${class}" 36
done

source ${DIR}/../email_setup.sh
python2 ${DIR}/../send_email.py -s "${SENDER_EMAIL}" -w "${SENDER_PASSWORD}" -m "${SMTP_SERVER}" "NASPB-MPI-TAU finished" "At `date`, NASPB-MPI-TAU benchmarks finished to run in `hostname`."
