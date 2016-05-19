#!/bin/bash

plot() {
  inputfile="${1}"
  scatterfile="${2}"
  boxplotfile="${3}"

  cat << EOF | gnuplot
set term pngcairo

# set title "Scatter plot"
set xlabel "Experiment"
set ylabel "Time(s)"
set xrange [:]
set yrange [:]
set xtics 1
set grid

set output "${scatterfile}"
plot "${inputfile}" using 1:2 title "Time(s)" pt 3 ps 3
set output "${boxplotfile}"
set style data boxplot
plot "${inputfile}" using 1:2 title "Time(s)" pt 3 ps 3
EOF
}

if [ "${#}" == "0" ]; then
  echo "usage: ${0} INPUTFILE [...]" 1>&2
  exit 1
fi

PARAM=""
N_PARAM=0
while (( "${#}" )); do
  PARAM=`echo ${PARAM} ${1}`
  let N_PARAM++
  # echo "Creating graphs for ${1}..."
  # plot "${1}" "${1}-scatter.png" "${1}-boxplot.png"
  shift
done
echo $PARAM $N_PARAM
