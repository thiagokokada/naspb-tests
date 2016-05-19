#!/bin/bash

set -e

COMPRESSED_DATA="${1}"
COMM_TYPES="NPB3.3.1-MPI NPB3.3.1-MPI-MZ NPB3.3.1-OMP"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CURRENT_DIR=`pwd`

extract_data() {
  for comm_type in ${COMM_TYPES}; do
    mkdir -p "${comm_type}"
    pushd "${comm_type}"
    echo
    for tarxz in `find "${1}/${comm_type}" -type f -name '*.tar.xz'`; do
      local dir=`basename -s '.tar.xz' "${tarxz}"`
      if [ ! -d "${dir}" ]; then
        mkdir "${dir}"
        pushd "${dir}"
        echo "Decompressing ${tarxz}"
        tar -xf ${tarxz}
        "${SCRIPT_DIR}/filter_data.sh"
        echo "Cleaning extra files"
        find -type f ! -name '*.data' -delete
        find -type d -delete
        popd
      else
        echo "Directory ${dir} already exists, skipping"
      fi
      echo
    done
    popd
  done
}

find_empty_files() {
  if find -type f -name *.data -empty | egrep '.*'; then
    echo "WARNING: empty .data files" 1>&2
    find -type f -name *.data -empty
    exit 1
  fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  if [ -z "${COMPRESSED_DATA}" ]; then
    echo "usage: ${0} COMPRESSED_DATA_DIR" 1>&2
    exit 1
  fi
  extract_data "${COMPRESSED_DATA}"
  find_empty_files
fi
