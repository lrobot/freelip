.IGNORE:

OPT=-O

# On Digital Unix / Alpha machines, the following works well.  Use ev4
# if appropriate for your chipset.
#
#OPT=-DALPHA -O -om -non_shared -tune ev5

lip.o: lippar.h lip.c lip.h
	cc $(OPT) lip.c -c

lippar.h: liptimer.c lip.c lip.h
	echo "" > lippar.h
	cc $(OPT) lip.c -c
	cc $(OPT) liptimer.c -c
	cc lip.o liptimer.o -lm -o liptimer
	echo "running timer program"
	./liptimer

.c: lip.o lippar.h lip.h
	cc $(OPT) $< lip.o -lm -o $@

clean:
	rm -f *.o
