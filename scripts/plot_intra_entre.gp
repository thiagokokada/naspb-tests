set terminal epscairo size 8,6 enhanced color font 'Helvetica, 20' linewidth 2
set encoding utf8

set title "Comunicação Intra-nós X Entre-nós"
set xlabel "VMs"
set ylabel "vCPUs"
set xrange [16:1]
set yrange [2:32]
set grid
set logscale xy 2

set output "intra_entre.eps"
plot 32/x title "Intra-nós X Entre-nós" with lines
