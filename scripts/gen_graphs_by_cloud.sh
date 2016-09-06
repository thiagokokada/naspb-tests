#!/bin/bash

DATA_DIR="${1}"
#SIZES="A B C D"
SIZES="C"
YRANGE="20:600"
CLOUD="GCE hydra revoada"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CURRENT_DIR=`pwd`

gen_graph() {
  local comm_type="${1}"
  local benchmark="${2}"
  local size="${3}"
  local nprocs="${4}"
  local cloud="${5}"

  data_name=${benchmark}.${size}.${nprocs}
  data=`find -type f -path "*${cloud}*${data_name}.data" | sort -V | tr '\n' ' '`
  echo "Generating ${cloud}.${comm_type}.${data_name}.eps"
  "${SCRIPT_DIR}/gen_comparison_boxplot.sh" "${YRANGE}" "${CURRENT_DIR}/`echo ${cloud}.${comm_type}.${data_name} | sed 's/\./_/g'`.eps" ${data_name} ${data}
  echo
}

gen_graphs() {
  for cloud in ${CLOUD}; do
    for size in ${SIZES}; do
      gen_graph "NPB3.3.1-MPI" lu "${size}" 32 "${cloud}"
      for benchmark in bt sp; do
        for nprocs in 25 36; do
          gen_graph "NPB3.3.1-MPI" "${benchmark}" "${size}" "${nprocs}" "${cloud}"
        done
      done
    done
    #for size in ${SIZES}; do
      #for benchmark in lu bt sp; do
        #gen_graph "NPB3.3.1-OMP" "${benchmark}" "${size}" "x" "${cloud}"
      #done
    #done
    for size in ${SIZES}; do
      for benchmark in lu-mz bt-mz sp-mz; do
        gen_graph "NPB3.3.1-MPI-MZ" "${benchmark}" "${size}" "*" "${cloud}"
      done
    done
  done
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  if [ -z "${DATA_DIR}" ]; then
    echo "usage: ${0} DATA_DIR" 1>&2
    exit 1
  fi
  pushd "${DATA_DIR}"
  gen_graphs
  popd
fi
