// This is the skeleton of a program.
// It does nothing other than exit gracefully

.global main                            // Make "main" visible to the linker". When compiling with
                                        // gcc, a "main" function must be visible.

main:
        // This is the function "prologue"
        stp x29, x30, [sp, -16]!        // Store X29 and X30 at the address pointed to by SP.
                                        // [SP, -16]! decreases SP by 16 *before* this operation
                                        // is done.
        mov x29, sp                     // Copy SP to X29

        // The body of your main function goes here.
        // ...
        // ...
        // ...
        mov x0, 0                       // Store the value 0 in the register x0.
                                        // By convention, functions use x0 to return values.
                                        // This makes main return 0.

        // This is the function "epilogue"
        ldp x29, x30, [sp], 16          // Load X29 and X30 from the address pointed to by SP.
                                        // [SP], 16 increases SP by 16 *after* this operation is
                                        // done.
        ret                             // "Returns" from this function. Sets the program counter
                                        // to the value stored in a register. If no register is
                                        // given, defaults to X30 (a.k.a. LR).

// When compiling with gcc, there are more than just these few lines of code.
// The "real" entry point to the program is a label called "_start". 
// (Try running gdb with the breakpoint "_start")
