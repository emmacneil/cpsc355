arm :	lfsr_arm.c
	gcc -g -c -o lfsr.o lfsr.c
	as -o lfsr_arm.o lfsr_arm.s
	gcc -g -o lfsr lfsr.o lfsr_arm.o

c:	lfsr.c
	gcc -g -o lfsr lfsr.c
intel :	lfsr_intel.c
	gcc -g -o lfsr lfsr_intel.c
