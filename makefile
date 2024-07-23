#
# Makefile for program '4hedft' 
# 3D static (imaginary time evolution) 4-He Density Functional Theory
#

COMP = ifx
CFLAGS = -c -O3 -xAVX -align array64byte -qopenmp\
		 -parallel -qopt-matmul -unroll0 -module ./modules
LD_FLAGS = -threads -I${MKLROOT}/include/fftw -qmkl=parallel -qopt-matmul

# Name of the program
PROGNAME = 4hedft

# Fortran objects
objs = init_deriv_parallel.o	V_impur.o       modules.o       FT_V_spline.o   BCN4HeDFT.o\
			derden.o	spline.o		dimen.o         energy.o        evolo.o         evolox.o\
            fforma.o			fft.o           initcg.o        ironing.o       mates.o\
            poten.o				printout.o      r_cm.o          readen.o        respar.o\
            term_alfa.o			timer.o         titols.o        vareps.o        varmu.o\
            tstgrid.o			s13adf.o        newder.o        redef.o         steprkr.o\
            steppcr.o			steprkrl.o       steppcrl.o     diag.o          instates.o\
            rhoasin0.o			instates_external.o

.SUFFIXES: .f90 .f .o

$(PROGNAME): $(objs)
	$(COMP) -o $(PROGNAME) $(objs)  $(LD_FLAGS)
.f90.o:
	$(COMP) $(CFLAGS) -o $(@) $<;
.f.o:
	$(COMP) $(CFLAGS) -o $(@) $<;

-init=snan

clean:
	rm -f *.o *.bak *.lst modules/*.mod;
distclean:
	rm -f *.o *.bak *.lst modules/*.mod $(PROGNAME);
