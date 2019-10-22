

fmt1:   .string "x19 is 100.\n"
fmt2:   .string "x19 is not 100.\n"
        .global main
        .balign 4

main:
        stp     x29, x30, [sp, -16]!    // Function prologue
        mov     x29, sp

        mov     x19, 107                  // Initialize x19 with some value

        // If x19 is 100, we want to print a message.
        // If x19 is not 100, print a different message.
        // We do this by comparing x19 to 100.
        // We skip the "if" part if they are inequal
        // If they are equal, we do the "if" part, then skip the "else" part

        cmp     x19, 100                  // Compare x19 to 100. If they are equal, a flag is set
        b.ne    else_part               // Skip the "if" part if they are inequal
if_part:
        adrp    X0, fmt1
        add     X0, X0, :lo12:fmt1
        b       after_else              // Skip over the "else" part
else_part:
        adrp    X0, fmt2
        add     X0, X0, :lo12:fmt2
after_else:
        bl      printf

        mov     x0, 0                   // Return with exit code 0
        ldp     x29, x30, [sp], 16      // Function epilogue
        ret
