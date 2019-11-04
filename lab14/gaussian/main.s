fmt:    .string "%ld + %ldi\n"
        .global main
        .balign 4

// Gaussian integers
gaussian_re = 0
gaussian_im = 8

// gaussian_print takes one argument, a pointer to a gaussian integer,
// and prints that integer to stdout.



main :
        
        
        
        x_s = 16
        y_s = 32
        z_s = 48

        stp     fp, lr, [sp, -64]!
        mov     fp, sp

        // Compute addresses of x, y, z
        add     x19, fp, x_s
        add     x20, fp, y_s
        add     x21, fp, z_s

        // Set x = 5 + 3i
        mov     x9, 5
        str     x9, [x19, gaussian_re]
        mov     x9, 3
        str     x9, [x19, gaussian_im]

        // Set y = 1 + 2i
        mov     x9, 1
        str     x9, [x20, gaussian_re]
        mov     x9, 2
        str     x9, [x20, gaussian_im]

        // Print x and y
        ldr     x0, =fmt
        ldr     x1, [x19, gaussian_re]
        ldr     x2, [x19, gaussian_im]
        bl      printf
        ldr     x0, =fmt
        ldr     x1, [x20, gaussian_re]
        ldr     x2, [x20, gaussian_im]
        bl      printf

        // Compute z = x + y
        mov     x0, x19
        mov     x1, x20
        mov     x8, x21
        bl      gaussian_add
        
        // Print z
        ldr     x0, =fmt
        ldr     x1, [x21, gaussian_re]
        ldr     x2, [x21, gaussian_im]
        bl      printf
        
        // Compute z = x*y
        mov     x0, x19
        mov     x1, x20
        mov     x8, x21
        bl      gaussian_mul
        
        // Print z
        ldr     x0, =fmt
        ldr     x1, [x21, gaussian_re]
        ldr     x2, [x21, gaussian_im]
        bl      printf

end_main :
        mov     x0, 0
        ldp     fp, lr, [sp], 64
        ret



// Adds two Gaussian integers
// Takes two arguments, pointers to Gaussian integers, in X0, and X1
// Before being called, a pointer should be placed in X8 to where the sum should be stored
gaussian_add :
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
        
        ret



// Adds two Gaussian integers
// Takes two arguments, pointers to Gaussian integers, in X0, and X1
// Before being called, a pointer should be placed in X8 to where the sum should be stored
gaussian_mul :
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
        
        ret
