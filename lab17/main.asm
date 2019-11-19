        .bss
z:      .skip   4

        .data
d:      .word   17

        .text
fmt:    .string "%d\n"
        .balign 4
        .global main

define(adr_z, x19)
define(adr_d, x20)
define(adr_fmt, x21)

main:   stp     fp, lr, [sp, -16]!
        mov     fp, sp

        adrp    adr_z, z
        add     adr_z, adr_z, :lo12:z
        adrp    adr_d, d
        add     adr_d, adr_d, :lo12:d
        adrp    adr_fmt, fmt
        add     adr_fmt, adr_fmt, :lo12:fmt
        
        // Print z
        mov     x0, adr_fmt
        ldr     w1, [adr_z]
        bl      printf

        // Print d
        mov     x0, adr_fmt
        ldr     w1, [adr_d]
        bl      printf

        // d = d + 1
        ldr     w0, [adr_d]
        add     w0, w0, 1
        str     w0, [adr_d]

        // z = z + d
        ldr     w0, [adr_z]
        ldr     w1, [adr_d]
        add     w0, w0, w1
        str     w0, [adr_z]

        // Print z
        mov     x0, adr_fmt
        ldr     w1, [adr_z]
        bl      printf

        // Print d
        mov     x0, adr_fmt
        ldr     w1, [adr_d]
        bl      printf

        mov     x0, 0
        ldp     fp, lr, [sp], 16
        ret
