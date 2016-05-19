#!/bin/bash

for file in `find -name '*.log'`; do
  echo "Processing ${file}..."
  grep 'Time in seconds' "${file}" | tr -s " " | cut -d" " -f6 | awk '{ print NR, $0 }' > "`basename "${file}" .log`.data"
done
