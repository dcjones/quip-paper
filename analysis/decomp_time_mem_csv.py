#!/usr/bin/env python

"""
Parse the output the timeit script for R.
"""

import re
from collections import defaultdict
from glob import glob


# Parse uncompressed sizes to normalize compression time
size = defaultdict(int)
for line in open("sizes.txt"):
    mat = re.match(r"\s*(\d+)\s+(.+)\n", line)
    n  = int(mat.group(1))
    fn = mat.group(2)

    if fn == "total": continue

    mat = re.match(r"(\d+)(_\d+)?\.fastq", fn)
    if mat:
        samp = mat.group(1)
        size[samp] += n
        continue



times = defaultdict(lambda: defaultdict(float))
mems  = defaultdict(lambda: defaultdict(list))

for fn in glob("*.decomp.csv"):
    prog = re.match(r"(.+)\.decomp\.csv", fn).group(1)

    for line in open(fn):
        row = line.strip().split(",")

        samp = re.match(r"(\d+)(_\d+)?\.(fastq|relabel\.bam)", row[0]).group(1)
        time = row[1]
        # Note: divide by four to overcome a strange bug in GNU time.
        mem  = float(row[2]) / 4

        times[prog][samp] += float(time)
        mems[prog][samp].append(float(mem))



f_time = open("decomp_time.csv", "w")
f_time.write("samp,prog,time\n")
for prog in times:
    for samp in times[prog]:
        f_time.write("{samp},{prog},{time}\n".format(
            samp = samp,
            prog = prog,
            time = (size[samp] / 1e6) / times[prog][samp]))


f_mem = open("decomp_mem.csv", "w")
f_mem.write("samp,prog,mem\n")
for prog in mems:
    for samp in mems[prog]:
        f_mem.write("{samp},{prog},{mem}\n".format(
            samp = samp,
            prog = prog,
            mem  = sum(mems[prog][samp]) / len(mems[prog][samp])))

