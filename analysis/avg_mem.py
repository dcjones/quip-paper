#!/usr/bin/env python

from collections import defaultdict

print("Compression")
f = open("comp_mem.csv")
f.readline() # header
mem = defaultdict(list)
for line in f:
    row = line.strip().split(",")
    mem[row[1]].append(float(row[2]))

for key in mem:
    print("{prog}\t{avgmem}".format(
        prog   = key,
        avgmem = (sum(mem[key]) / float(len(mem[key]))) / 1000.0))


print("\n\nDecompression")
f = open("decomp_mem.csv")
f.readline() # header
mem = defaultdict(list)
for line in f:
    row = line.strip().split(",")
    mem[row[1]].append(float(row[2]))

for key in mem:
    print("{prog}\t{avgmem}".format(
        prog   = key,
        avgmem = (sum(mem[key]) / float(len(mem[key]))) / 1000.0))
