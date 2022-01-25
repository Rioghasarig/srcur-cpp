#
# Makefile for mxlu1fac
#
# Copyright (C) 2005 Yin Zhang yzhang@cs.utexas.edu
#

CC = gcc
MX = mex
RM = rm -f

OBJS 	= commonlib.o hbio.o lusol.o lusolio.o lusolmain.o mmio.o myblas.o

OBJS2   = commonlib.o hbio.o lusol.o lusolio.o mmio.o myblas.o

MXSRCS  = mxlu1fac.c commonlib.c lusol.c myblas.c

CFLAGS 	= -DYZHANG -DNDEBUG -Wall -fexceptions  -ansi -fPIC -O0  -g

MXFLAGS = -DMATLAB -DYZHANG -O # -g

#BLAS 	= /p/lib/prescott_gotoblas.so
#BLAS	= /usr/local/matlab/bin/glnx86/libmwrefblas.so
BLAS    = /global/home/groups/consultsw/sl-7.x86_64/modules/blas/3.8.0/libblas.so
LIBS 	= $(BLAS) -lm  -ldl

#--------------------------------------------------------------------------

all: mxlu1fac lusol

mxlu1fac: $(MXSRCS)
	$(MX) $(MXFLAGS) $(MXSRCS) $(LIBS)

lusol: $(OBJS)
	$(CC) -o lusol $(CFLAGS) $(OBJS) $(LIBS)

srcur-test:
	gcc -g -O0 -o srcur-test srcur-test.c $(CFLAGS) $(OBJS2) $(LIBS)

clean: 
	$(RM)  $(OBJS) *.dll srcur-test lusol

distclean: clean
	$(RM) -f *.mex* lusol



