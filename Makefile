# -*- coding: utf-8; mode: makefile -*-

par = 0
ifeq ($(par),1)
	CC = mpic++
	SRCS = Game_Of_Life_Parallel.cc
	PROJECT= GOL_P
else
 # Serial
	CC = g++
	SRCS = SEM_serial.cpp fedata.cpp vtk.cpp aux.cpp transient.cpp
	PROJECT= SEM_s
endif

objects = $(patsubst %.cpp, %.o,$(SRCS))
LINKFLAGS=
CFLAGS= -Wno-deprecated -g

########
# BLAS #
########
LIBBLAS = -lblas
INCBLAS = -I/usr/include/

#######
# VTK #
#######
LIBVTK = -L/usr/lib/ -lvtkCommon -lvtkIO -lvtkFiltering
INCVTK = -I/usr/include/vtk-5.8


LIBS= ${LIBVTK} ${LIBBLAS}
INCLUDE = ${INCVTK} ${INCBLAS}


.PHONY: all
all:${PROJECT}
	$(shell etags $(SRCS))

#$(shell ctags -Re)


# regel for exe-filen, dvs link filer
${PROJECT}: $(objects)
	$(CC) $(objects) $(LINKFLAGS) $(LIBS) -o ${PROJECT}


%.o: %.cpp
	$(CC) $(INCLUDE) $(CFLAGS) -c $< -o $@


# special rule for the file containing exodus_ref
.PHONY: clean
clean:
	rm -f *.o
	rm -f $(PROJECT)
	rm -f TAGS
