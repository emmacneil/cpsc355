// Example of nested structures
fmt:    .string "#%02hhx%02hhx%02hhx%02hhx\n"
        .global main
        .balign 4

DEFAULT_R = 1
DEFAULT_G = 2
DEFAULT_B = 3
DEFAULT_A = 255

point2d_x = 0
point2d_y = 4
sizeof_point2d = 8

size2d_w = 0
size2d_h = 4
sizeof_size2d = 8

color4d_r = 0
color4d_g = 1
color4d_b = 2
color4d_a = 3
sizeof_color4d = 4

rect_point = 0
rect_size = rect_point + sizeof_point2d
rect_color = rect_size + sizeof_size2d
sizeof_rect = sizeof_point2d + sizeof_size2d + sizeof_color4d



rect_s = 16
main_alloc = -(16 + sizeof_rect) & -16
main : 
        stp     fp, lr, [sp, main_alloc]!
        mov     fp, sp

        // Call new_rect(-1, 2, 3, 4), creating a new rectangle with values
        //      (x, y, w, h) = (-1, 2, 3, 4)
        // and with default values for (r, g, b, a).
        // We must also compute the address at which this rectangle will be stored before
        // calling new_rect.
        mov     w0, -1
        mov     w1, 2
        mov     w2, 3
        mov     w3, 4
        add     x8, fp, rect_s
        bl      new_rect
        
        // Compute the address of the rectangle again and place it in X0, to give it as an
        // argument to print_rect_color. (We could just do 'mov X0, X8' since the address was
        // already in X8, but this is unsafe since new_rect is not guaranteed to preserve X8.)
        add     x0, fp, rect_s
        bl      print_rect_color

        mov     x0, 0
        ldp     fp, lr, [sp], -main_alloc
        ret



// This is a leaf function so there is no need to back up FP and LR.
// It uses no local variables, so it does not need to allocate more stack space.
new_rect :
        // add     x9, x8, rect_point
        // str     w0, [x9, point2d_x]
        // str     w1, [x9, point2d_y]

        str     w0, [x8, rect_point + point2d_x]
        str     w1, [x8, rect_point + point2d_y]
        
        add     x9, x8, rect_size
        str     w2, [x9, size2d_w]
        str     w3, [x9, size2d_h]

        mov     w0, DEFAULT_R
        mov     w1, DEFAULT_G
        mov     w2, DEFAULT_B
        mov     w3, DEFAULT_A

        add     x9, x8, rect_color
        strb    w0, [x9, color4d_r]
        strb    w1, [x9, color4d_g]
        strb    w2, [x9, color4d_b]
        strb    w3, [x9, color4d_a]
        
        ret



// This is not a leaf function. We must back up fp and lr before calling printf
// This function has no local variables, so just allocate 16 bytes.
print_rect_color :
        stp     fp, lr, [sp, -16]!
        mov     fp, sp

        // Get memory address of rect->color, and store it in X9
        add     x9, x0, rect_color

        adrp    x0, fmt
        add     x0, x0, :lo12:fmt
        ldrb    w1, [x9, color4d_r]     // Store rect->color.r in w1
        ldrb    w2, [x9, color4d_g]     // Store rect->color.g in w2
        ldrb    w3, [x9, color4d_b]     // Store rect->color.b in w3
        ldrb    w4, [x9, color4d_a]     // Store rect->color.a in w4
        bl      printf

        ldp     fp, lr, [sp], 16
        ret
