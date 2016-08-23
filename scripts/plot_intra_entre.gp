set terminal epscairo size 3.5,2.62 enhanced color font 'Helvetica, 14' linewidth 1.5
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
