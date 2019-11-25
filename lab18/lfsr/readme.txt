An LFSR (linear-feedback shift register) is a digital circuit (or a software
implementation of one) that can create a pseudo-random sequence of 0's and 1's.
For more info, see:

	https://en.wikipedia.org/wiki/Linear-feedback_shift_register

They are used sometimes to produce random numbers, and in cryptography to
encrypt streams of data. The LFSR in this code sample is not cryptographically
secure.

The C compiler does not make good use registers or the full instruction set
available on a CPU. In this code example, the LFSR function is defined in
an assembly code file, where it can be implemented more efficiently than in C.
The ARM64 version makes use of rotation operations not available in C, and can
be compiled on the ARM server at arm.cpsc.ucalgary.ca by running

	make arm

An even more efficient Intel x64 version makes use of a Hamming weight
operation (POPCNT) not available in C, and can be compiled on the Linux server
at linux.cpsc.ucalgary.ca by running

	make intel

This code sample demonstrates use of static variables, makefiles, separate
compilation of code into binary object files, and linking objects files
into an executable.
