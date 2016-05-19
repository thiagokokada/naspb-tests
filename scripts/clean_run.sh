#!/bin/bash

for ip in `cut -f1 -d" " hostfile.txt`; do
  ssh "${ip}" "killall sar; rm -rf *.log *.sa cpuinfo_* lscpu_*"
done
