F90 = /c/MinGW/bin/gfortran.exe
FFLAGS = -static -ofast

################################

MOD_OBJ = zen_module.o

F90_OBJ = zen.o

EXEC = zengarden
################################ Libraries

ALL_OBJS = $(MOD_OBJ) $(F90_OBJ)

zengarden: $(ALL_OBJS)
	$(F90) $(FFLAGS) $(ALL_OBJS) -o $(EXEC)
	
clean:
		#rm *.mod *.o $(EXEC)
	
################################ Rules
zen_module.o		:	zen_module.f90
		$(F90) $(FFLAGS) -c zen_module.f90
zen.o				:	zen.f90 $(MOD_OBJ)
		$(F90) $(FFLAGS) -c zen.f90
		
		
