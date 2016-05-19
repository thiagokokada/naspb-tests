#!/bin/bash

master=`head -n1 hostfile.txt | cut -f1 -d" "`
echo "Compressing logs from ${master}..."
tar cfvJ "logs_${master}.tar.xz" *.log *.sa cpuinfo_* lscpu_*
echo

for ip in `tail -n+2 hostfile.txt | cut -f1 -d" "`; do
  echo "Compressing logs from ${ip}..."
  ssh "${ip}" "cd `pwd`; tar cfvJ \"logs_${ip}.tar.xz\" *.sa cpuinfo_* lscpu_*"
  echo "Sending logs from ${ip} to ${master}..."
  scp "${ip}:`pwd`/logs_${ip}.tar.xz" .
  echo
done
