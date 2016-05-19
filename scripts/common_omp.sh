export OMP_NUM_THREADS=32
export OMP_NUM_THREADS2=2 # For OMP-MZ 

# run_bench(bench, class, nprocs, repetitions)
run_bench() {
  local bench="${1}"
  local class="${2}"
  local repetitions="${3}"
  local name="${bench}.${class}.x"
  local interval="10"

  nohup sar -o "${name}.sa" 5 > /dev/null 2>&1 &
  cat /proc/cpuinfo > "cpuinfo_${name}"
  lscpu > "lscpu_${name}"
  sleep "${interval}"

  for i in `seq ${repetitions}`; do
    echo "Running ${name} (${i}/${repetitions})" | tee -a "${name}.log"
    date | tee -a "${name}.log"
    ./"${name}" | tee -a "${name}.log"
    date | tee -a "${name}.log"
    echo | tee -a "${name}.log"
    sleep "${interval}"
  done

  killall sar
}


# compile_bench(bench, nprocs, class)
compile_bench() {
  local bench="${1}"
  local class="${2}"

  make "${bench}" CLASS="${class}"
}
