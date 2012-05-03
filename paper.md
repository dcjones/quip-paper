% Compression of next-generation sequencing reads aided by highly efficient de novo assembly
% Daniel C. Jones
% \today

# Abstract

We present Quip, an extremely efficient compression algorithm for
high-throughput sequencing data.  We use reference-based compression for aligned
reads in the SAM/BAM format to avoid storing redundant sequences.  Unaligned
reads are assembled into contigs using an novel de novo assembly algorithm that
far more space efficient than traditional assemblers.  Read identifiers and
quality scores are compressed using arithmetic coding with straightforward
statistical modeling.

Availability: Quip is freely available under an open-source license from
\url{http://cs.washington.edu/homes/dcjones/quip}.


# Introduction

<!-- Notes on tho cost of sequencing versus the cost of disk storage. -->

<!-- Historical work compressing DNA -->

<!-- Recent work compressing short reads -->

<!-- Lossyness -->


# Methods

## Probabalistic De Bruijn Graph Assembly

## Statistical Compression with Arithmetic Coding

### Read Identifiers

### Nucleotide Sequences

### Quality Scores

# Referenced Based Compression




# Results

<!-- Chosen datasets. -->

## Compression of Unaligned Reads

## Reference-based Compression of Aligned Reads

## Characteristics of the d-left Counting Bloom Filter

Though our primary goal is efficient compression of sequencing data, the
assembly algorithm we developed to achieve this is of independent interest.
Only very recently has the idea of using probabilistic data structures in
assembly been breached, and to our knowledge, we are the first to build
a functioning assembler using the dlCBF.

The precise false-positive rate of the data structure is unimportant when the
goal is compression, but if the method is to be extended to perform actual
analysis, it becomes a serious concern. The false positive rate of a Bloom
filter can be obtained analytically, though doing so is not entirely trivial.

Comparisons of data structure performance are notoriously sensitive to the
particulars of the implementation. To perform a meaningful benchmark, we
compared our dlCBF implementation to the sparsehash library, an open source
hash table implementation with the expressed goal of maximizing space
efficiency. Among many other uses, it is the core data structure in the ABySS
and PASHA assemblers.

We randomly generated 10 million unique 25-mers and inserted them into an
appropriately sized hash table, and to explore the trade-off between space and
false positive rate, dlCBF tables of varying sizes. Run time and maximum
memory usage were both recorded using the UNIX time command.

![TODO: caption](analysis/dlcbf/benchmark.pdf)

Using only 20% of the space of the sparsehash table we accrue a false positive
rate of less than 0.001.

Though the authors of sparsehash claim only a 4 bit overhead for each entry,
and have gone to considerably effort to achieve such efficiency, it still must
store the $k$-mer itself, encoded in 64 bits. The dlCBF avoids this, storing
instead a 14-bit ``fingerprint'', or hash of a $k$-mer, resulting in the large
savings we observe. Of course, a 25-mer cannot be uniquely identified with 14
bits. False positives are thus introduced, yet they are kept at a very low
rate by the d-left hashing scheme. Since multiple hash functions are used
under this scheme, multiple collisions must occur to result in a false
positive; an infrequent event if reasonably high-quality hash functions are
chosen.

# Discussion



