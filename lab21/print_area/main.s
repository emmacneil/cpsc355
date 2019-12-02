circle_x = 0
circle_y = 8
circle_r = 16
sizeof_circle = 24

        .text
PI:     .double 0r3.141592653589793
fmt:    .string "Volume = %.10lf\n"

        .balign 4
        .global main
circle_s = 16
a_s      = circle_s + sizeof_circle
alloc = -(16 + 8 + sizeof_circle) & -16
main:   stp     fp, lr, [sp, alloc]!
        mov     fp, sp

        // Initialize the circle to some values
        // Set (x, y) = (1.0, -1.0) and r = sqrt(2.0)
        fmov    d0, 1.0
        str     d0, [fp, circle_s + circle_x]
        fmov    d0, -1.0
        str     d0, [fp, circle_s + circle_y]
        fmov    d0, 2.0
        fsqrt   d0, d0
        str     d0, [fp, circle_s + circle_r]

        // Compute area
        add     x0, fp, circle_s
        bl      area
        str     d0, [fp, a_s]

        // Print area
        adrp    x0, fmt
        add     x0, x0, :lo12:fmt
        ldr     d0, [fp, a_s]
        bl      printf

        mov     w0, 0
        ldp     fp, lr, [sp], -alloc
        ret

// double area(struct circle * c)
//
// Compute the area of the circle c.
// (The result is put in register d0)
        .global area
area:   ldr     d0, [x0, circle_r]
        adrp    x1, PI
        add     x1, x1, :lo12:PI
        ldr     d1, [x1]
        fmul    d0, d0, d0
        fmul    d0, d0, d1
        ret
