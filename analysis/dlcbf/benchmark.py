#!/usr/bin/env pypy

"""
Generate run-time and memory usage statistics for the dlCBF and sparsehash.
"""

import numpypy as np
import re
import subprocess
import argparse
from random import randint


def timeit(cmd, input, parse_fpr = False):
    proc = subprocess.Popen(
        ["gtime", "-f", "%e,%M"] + cmd,
        stdout = subprocess.PIPE,
        stderr = subprocess.PIPE,
        stdin  = subprocess.PIPE)

    (out, err) = proc.communicate(input)

    fpr = 0.0
    if parse_fpr:
        mat = re.match(r"(\d+)\t(\d+)", out)
        (u, v) = (int(mat.group(1)), int(mat.group(2)))
        fpr = 1.0 - float(u) / float(v)

    err = err.split("\n")

    mat = re.match(r"([\d\.]+),([\d\.]+)", err[-2])

    return (float(mat.group(1)), float(mat.group(2)), fpr)


def rand_int_set(n, low, high):
    '''
    Generate n random in [low, high]
    without replacement.
    '''

    xs = set()
    ys = []
    while len(xs) < n:
        x = randint(low, high)
        if x not in xs:
            xs.add(x)
            ys.append(x)

    return ys


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("-n", default = 10000000, type = int)
    ap.add_argument("-k", default = 25, type = int)
    args = ap.parse_args()

    input = "\n".join(map(str, rand_int_set(args.n, 0, 4 ** args.k - 1)))


    (t_base, m_base, _) = timeit(["./sparsehash_stats", "-n", str(args.n)], input)

    print("baseline: {0} seconds, {1} bytes".format(t_base, m_base))


    f = open("benchmark.tsv", "w")
    f.write("time\tmem\tfpr\n")

    cs = [0.01]
    d = 0.01
    while cs[-1] < 4.0:
        cs.append(cs[-1] + d)

    for c in cs:
        N = (c * args.n) / 8 / 4
        (t, m, fpr) = timeit(["./bloom_stats", "-m", "8", "-n", str(N)], input, parse_fpr = True)
        print((c,fpr))
        f.write("\t".join(map(str, [t/t_base, m/m_base, fpr])))
        f.write("\n")


if __name__ == "__main__": main()
