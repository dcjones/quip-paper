#!/usr/bin/env python

import re
from collections import namedtuple, defaultdict

lstrow = namedtuple("lstrow",
    "reads bases id_bytes id_comp_bytes id_ratio " \
    "aux_bytes aux_comp_bytes aux_ratio " \
    "seq_bytes seq_comp_bytes seq_ratio " \
    "qual_bytes qual_comp_bytes qual_ratio fn")

samples = set()
progs   = ["quip", "quip-quick", "quip-ref"]
sizes   = defaultdict(int)

# uncompressed size
f = open("quip.comp.list.tab")
f.readline() # header
for line in f:
    row = lstrow(*line.split())
    sample = re.match(r"\d+", row.fn).group(0)
    sizes[(sample,"uncompressed","id")] += float(row.id_bytes)
    sizes[(sample,"uncompressed","seq")] += float(row.aux_bytes) + float(row.seq_bytes)
    sizes[(sample,"uncompressed","qual")] += float(row.qual_bytes)


for prog in progs:
    f = open(prog + ".comp.list.tab")
    f.readline() # header
    for line in f:
        row = lstrow(*line.split())

        sample = re.match(r"\d+", row.fn).group(0)
        samples.add(sample)

        sizes[(sample,prog,"id")] += float(row.id_comp_bytes)
        sizes[(sample,prog,"seq")] += float(row.aux_comp_bytes) + float(row.seq_comp_bytes)
        sizes[(sample,prog,"qual")] += float(row.qual_comp_bytes)


f = open("quip_relative_size.csv", "w")
f.write("samp,prog,grp,size\n")
for sample in samples:
    for prog in ["uncompressed"] + progs:
        if (sample,prog,"id") not in sizes: continue
        n = sum(sizes[(sample, prog, grp)] for grp in ["id", "seq", "qual"])
        if n == 0: print((sample, prog))
        for grp in ["id", "seq", "qual"]:
            f.write("{samp},{prog},{grp},{size}\n".format(
                samp   = sample,
                prog   = prog,
                grp    = grp,
                size   = sizes[(sample, prog, grp)] / n))
