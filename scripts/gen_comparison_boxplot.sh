#!/bin/bash

if [ -z "${1}" ] || [ -z "${2}" ]; then
  echo "usage: ${0} YRANGE OUTFILE DATA_FILE [[DATA_FILE]...]" 1>&2
  exit 1
fi

YRANGE="${1}"
OUTFILE="${2}"
shift
TITLE="${2}"
shift
SIZE=`sed 's/[^A-Z]//g' ${3}`

GNUPLOT_SCRIPT="
# set term pngcairo size 800,600 enhanced font 'Verdana, 14'
# set term svg size 800,600 enhanced font 'Verdana, 14' background rgb 'white'
set terminal epscairo size 8,6 enhanced color font 'Helvetica,20' linewidth 2
set style data boxplot
set output \""${OUTFILE}"\"

set title \"${TITLE}\"
set xlabel \"Experiment\"
set ylabel \"Time(s)\"
set xrange [:]
set yrange ["${YRANGE}"]
set grid
set xtics rotate by 30 right
unset key
"

add_xtick() {
  XTICS="${XTICS} \"${1%.data}\" ${2},"
}

add_xtick2() {
  local title="`echo "${1}" | cut -d'/' -f3`"
  XTICS="${XTICS} \"${title}\" ${2},"
}

add_plot() {
  local file="${1}"
  local pos="${2}"
  local graph="${file%.data}"
  local template="\""${1}"\" using (${pos}):2 title \"${graph}\","
  GNUPLOT_SCRIPT="${GNUPLOT_SCRIPT} ${template}"
}

FILES=${@}
XTICS="set xtics("
n=1
for i in ${FILES}; do
  add_xtick2 "${i}" "${n}"
  let n++
done

GNUPLOT_SCRIPT="${GNUPLOT_SCRIPT}
${XTICS})
plot"

FILES=${@}
n=1
for i in ${FILES}; do
  add_plot "${i}" "${n}"
  let n++
done

echo -e "${GNUPLOT_SCRIPT}"
echo -e "${GNUPLOT_SCRIPT}" | gnuplot
