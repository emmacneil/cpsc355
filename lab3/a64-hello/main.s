fmt:    .string "Hello, world!\n"

.balign 4
.global main

main:
        stp     x29, x30, [sp, -16]!    // Function prologue
        mov     x29, sp

        // By convention, arguments to function call are placed in registers X0-X7.
        // printf's first argument is a string.
        // printf expects another argument for each format code (.e.g %d) in that string.
        // "Hello, world\n", has no format codes, so we only give it one argument (in X0)
        // The next two instructions compute the address of fmt and store that address in X0
        adrp    x0, fmt                 // Find the 4KB "page" of memory in which fmt is stored,
                                        // multiply that by 4096 (2^12), and store the result in X0
        add     x0, x0, :lo12:fmt       // Add the least significant 12 bits of fmt's address to X0
        bl      printf                  // Call printf

        mov     x0, 0                   // Exit program with code 0
        ldp     x29, x30, [sp], 16      // Function epilogue
        ret
