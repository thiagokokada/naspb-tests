# run_bench(bench, class, nprocs, repetitions)
run_bench() {
  local bench="${1}"
  local class="${2}"
  local nprocs="${3}"
  local repetitions="${4}"
  local name="${bench}.${class}.${nprocs}"
  local hostfile="hostfile.txt"
  local interval="10"

  for ip in `cut -d" " -f1 "${hostfile}"`; do
    ssh "${ip}" "cat /proc/cpuinfo > \"`pwd`/cpuinfo_${name}_${ip}\"; lscpu > \"`pwd`/lscpu_${name}_${ip}\""
    ssh "${ip}" "cd `pwd`; nohup sar -o \"${name}.sa\" 5 > /dev/null 2>&1 &"
  done
  sleep "${interval}"

  for i in `seq ${repetitions}`; do
    echo "Running ${name} (${i}/${repetitions})" | tee -a "${name}.log"
    date | tee -a "${name}.log"
    mpirun -np "${nprocs}" -hostfile "${hostfile}" -x OMP_NUM_THREADS "${name}" | tee -a "${name}.log"
    date | tee -a "${name}.log"
    echo | tee -a "${name}.log"
    sleep "${interval}"
  done

  for ip in `cut -d" " -f1 "${hostfile}"`; do
    ssh "${ip}" "killall sar"
  done
}

# compile_bench(bench, nprocs, class)
compile_bench() {
  local bench="${1}"
  local nprocs="${2}"
  local class="${3}"

  make "${bench}" NPROCS="${nprocs}" CLASS="${class}"
}
