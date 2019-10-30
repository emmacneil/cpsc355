fmt:    .string "%ld + %ldi\n"
        .global main
        .balign 4

// Gaussian integers
gaussian_re = 0
gaussian_im = 8

main :
        define(x_base_r, x19)
        define(y_base_r, x20)
        define(z_base_r, x21)
        x_s = 16
        y_s = 32
        z_s = 48

        stp     fp, lr, [sp, -64]!
        mov     fp, sp

        // Compute addresses of x, y, z
        add     x_base_r, fp, x_s
        add     y_base_r, fp, y_s
        add     z_base_r, fp, z_s

        // Set x = 5 + 3i
        mov     x9, 5
        str     x9, [x_base_r, gaussian_re]
        mov     x9, 3
        str     x9, [x_base_r, gaussian_im]

        // Set y = 1 + 2i
        mov     x9, 1
        str     x9, [y_base_r, gaussian_re]
        mov     x9, 2
        str     x9, [y_base_r, gaussian_im]

        // Print x and y
        mov     x0, x_base_r
        bl      gaussian_print
        mov     x0, y_base_r
        bl      gaussian_print

        // Compute z = x + y
        mov     x0, x_base_r
        mov     x1, y_base_r
        mov     x8, z_base_r
        bl      gaussian_add
        
        // Print z
        mov     x0, z_base_r
        bl      gaussian_print
        
        // Compute z = x*y
        mov     x0, x_base_r
        mov     x1, y_base_r
        mov     x8, z_base_r
        bl      gaussian_mul
        
        // Print z
        mov     x0, z_base_r
        bl      gaussian_print

end_main :
        mov     x0, 0
        ldp     fp, lr, [sp], 64
        ret



// Prints a Gaussian integer.
// Takes one argument, a pointer to a Gaussian integer, in X0
gaussian_print :
        stp     fp, lr, [sp, -16]!
        mov     fp, sp

        // We need to put the address of the format string in X0 before calling printf, but
        // X0 contains the pointer to the Guassian integer to print. Therefore, load the real
        // and imaginary parts of the integer into X1 and X2 first.
        ldr     x1, [x0, gaussian_re]
        ldr     x2, [x0, gaussian_im]
        ldr     x0, =fmt
        bl      printf

        ldp     fp, lr, [sp], 16
        ret
        


// Adds two Gaussian integers
// Takes two arguments, pointers to Gaussian integers, in X0, and X1
// Before being called, a pointer should be placed in X8 to where the sum should be stored
gaussian_add :
        stp     fp, lr, [sp, -16]!
        mov     fp, sp
        
        // Load the real and imaginary parts of both Gaussian integers into registers
        ldr     x9,  [x0, gaussian_re]
        ldr     x10, [x0, gaussian_im]
        ldr     x11, [x1, gaussian_re]
        ldr     x12, [x1, gaussian_im]

        add     x9, x9, x11             // Add the real parts
        add     x10, x10, x12           // Add the imaginary parts

        // Store the result in the address pointed to by X8
        str     x9,  [x8, gaussian_re]
        str     x10, [x8, gaussian_im]
        
        ldp     fp, lr, [sp], 16
        ret



// Adds two Gaussian integers
// Takes two arguments, pointers to Gaussian integers, in X0, and X1
// Before being called, a pointer should be placed in X8 to where the sum should be stored
gaussian_mul :
        stp     fp, lr, [sp, -16]!
        mov     fp, sp
        
        // Load the real and imaginary parts of both Gaussian integers into registers
        ldr     x9,  [x0, gaussian_re]
        ldr     x10, [x0, gaussian_im]
        ldr     x11, [x1, gaussian_re]
        ldr     x12, [x1, gaussian_im]

        // Compute real part of product, x9*x11 - x10*x12, and store the result
        mul     x13, x9, x11
        mul     x14, x10, x12
        sub     x13, x13, x14
        str     x13, [x8, gaussian_re]
        
        // Compute imaginary part of product, x9*x12 + x10*x11, and store the result
        mul     x13, x9, x12
        mul     x14, x10, x11
        add     x13, x13, x14
        str     x13, [x8, gaussian_im]
        
        ldp     fp, lr, [sp], 16
        ret
