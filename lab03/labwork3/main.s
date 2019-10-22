.global main
.balign 4

main:
        stp x29, x30, [sp, -16]!        // Function prologue
        mov x29, sp

        // Write a program that
        // Stores an integer (of your choice) in X1
        // Stores another integer (of your choice) in X2
        // Computes X1*X1 - 2*X1*X2 + X2*X2
        // Stores the result in X3
        // Does not overwrite X1 or X2
        // Exits "normally" (with code 0)

        // Set a breakpoint before the function epilogue
        // Use gdb to inspect the contents of X1, X2, X3 before the program exits
        // Try this for several values of X1 and X2

        // Call printf to print the value of X3.
        
        ldp x29, x30, [sp], 16          // Function epilogue
        ret
