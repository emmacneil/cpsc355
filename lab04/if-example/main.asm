define(N, x19)

fmt:    .string "N is 100"
        .global main
        .balign 4

main:
        stp     x29, x30, [sp, -16]!    // Function prologue
        mov     x29, sp

        mov     N, 100                  // Initialize N with some value

        // If N is 100, we want to print a message.
        // We do this by comparing N to 100, and *skipping* the print if they are different.

        cmp     N, 100                  // Compare N to 100. If they are equal, a flag is set
        b.ne    after_print             // Skip the print statement if they are inequal

        adrp    X0, fmt
        add     X0, X0, :lo12:fmt
        bl      printf
after_print:

        mov     x0, 0                   // Return with exit code 0
        ldp     x29, x30, [sp], 16      // Function epilogue
        ret
