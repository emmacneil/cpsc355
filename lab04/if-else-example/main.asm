define(N, x19)

fmt1:   .string "N is 100.\n"
fmt2:   .string "N is not 100.\n"
        .global main
        .balign 4

main:
        stp     x29, x30, [sp, -16]!    // Function prologue
        mov     x29, sp

        mov     N, 107                  // Initialize N with some value

        // If N is 100, we want to print a message.
        // If N is not 100, print a different message.
        // We do this by comparing N to 100.
        // We skip the "if" part if they are inequal
        // If they are equal, we do the "if" part, then skip the "else" part

        cmp     N, 100                  // Compare N to 100. If they are equal, a flag is set
        b.ne    else_block              // Skip the "if" part if they are inequal
if_block:
        adrp    X0, fmt1
        add     X0, X0, :lo12:fmt1
        bl      printf
        b       after_else              // Skip over the "else" part
else_block:
        adrp    X0, fmt2
        add     X0, X0, :lo12:fmt2
        bl      printf
after_else:

        // Note : The instruction "bl printf" is common to both the if- and else- blocks
        //        We could move the "bl printf" instruction outside (after) the if-else statement 

        mov     x0, 0                   // Return with exit code 0
        ldp     x29, x30, [sp], 16      // Function epilogue
        ret
