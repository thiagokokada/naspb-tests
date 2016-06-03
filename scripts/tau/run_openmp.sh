#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/../common_mpi.sh

run_bench() {
  local bench="${1}"
  local class="${2}"
  local nprocs="${3}"
  local hostfile="hostfile.txt"
  local interval="10"
  local name="${bench}.${class}.${nprocs}"

  ./"${name}"
  tar cfJ "${name}.tar.xz" profile.*
  rm -rf profile.*
  sleep "${interval}"
}

run_bench lu "${class}" x
run_bench sp "${class}" x
run_bench bt "${class}" x

source ${DIR}/../email_setup.sh
python2 ${DIR}/../send_email.py -s "${SENDER_EMAIL}" -w "${SENDER_PASSWORD}" -m "${SMTP_SERVER}" "NASPB-MPI-TAU finished" "At `date`, NASPB-MPI-TAU benchmarks finished to run in `hostname`."
