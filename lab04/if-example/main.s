

fmt:    .string "NN is 100"
        .global main
        .balign 4

main:
        stp     x29, x30, [sp, -16]!    // Function prologue
        mov     x29, sp

        mov     x19, 100                  // Initialize x19 with some value

        // If x19 is 100, we want to print a message.
        // We do this by comparing x19 to 100, and *skipping* the print if they are different.

        cmp     x19, 100                  // Compare x19 to 100. If they are equal, a flag is set
        b.ne    after_print             // Skip the print statement if they are inequal

        adrp    X0, fmt
        add     X0, X0, :lo12:fmt
        bl      printf
after_print:

        mov     x0, 0                   // Return with exit code 0
        ldp     x29, x30, [sp], 16      // Function epilogue
        ret
