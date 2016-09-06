#!/usr/bin/env python

import sys
import statistics

times = []
with open(sys.argv[1], 'r') as f:
    for line in f:
        times.append(float(line.split(' ')[1]))
print(statistics.mean(times), statistics.stdev(times))
