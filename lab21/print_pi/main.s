// This program simply prints out the value of PI.
// PI is stored as a constant in the read-only text section.
// Notice before the call to printf, PI is stored in D0, not D1.

        .text
PI:     .double 0r3.141592653589793
fmt:    .string "pi = %.10lf\n"

        .balign 4
        .global main
main:   stp     fp, lr, [sp, -16]!
        mov     fp, sp

        adrp    x0, fmt                 // Store address of fmt string in X0
        add     x0, x0, :lo12:fmt
        adrp    x1, PI                  // Store address of PI in X1
        add     x1, x1, :lo12:PI
        ldr     d0, [x1]                // Load value of PI into D0.
        bl      printf

        mov     w0, 0
        ldp     fp, lr, [sp], 16
        ret
