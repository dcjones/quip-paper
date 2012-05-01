
CFLAGS=-O3

all : bloom_stats sparsehash_stats

%.o : %.c
	gcc $(CFLAGS) -c -o $@ $<

%.o : %.cpp
	g++ $(CFLAGS) -c -o $@ $<

bloom_stats : bloom_stats.o bloom.o kmer.o misc.o
	gcc $(CFLAGS) -o $@ $^

sparsehash_stats : sparsehash_stats.o
	g++ $(CFLAGS) -o $@ $^

clean :
	rm -f *.o bloom_stats sparsehash_stats
