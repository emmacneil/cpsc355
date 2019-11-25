arm :	lfsr_arm.s lfsr.c
	gcc -g -c lfsr.c
	as -o lfsr_arm.o lfsr_arm.s
	gcc -g -o lfsr lfsr.o lfsr_arm.o

intel :	lfsr_intel.s lfsr.c
	gcc -g -c lfsr.c
	nasm -felf64 -Fdwarf -g lfsr_intel.s
	gcc -g -o lfsr lfsr.o lfsr_intel.o

clean :
	rm lfsr *.o
