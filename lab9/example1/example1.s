// Example 1 --- Calling functions with more than 8 parameters
//
// The 8 registers X0-X7 are used to pass arguments to functions. If a function takes more than
// 8 arguments, it looks for the other arguments on the stack. The stack pointer SP is expected
// to point to the 8th argument. The 9th, 10th, etc. are at higher memory addresses.

fmt: .string "%ld %ld %ld %ld %ld %ld %ld %ld %ld %ld.\n"

.balign 4
.global main

fp .req x29
lr .req x30

main :
        stp     fp, lr, [sp, -16]!
        mov     fp, sp

        // Call printf with 11 arguments (1 string and 10 integers)
        adrp    x0, fmt
        add     x0, x0, :lo12:fmt
        mov     x1, 1
        mov     x2, 2
        mov     x3, 3
        mov     x4, 4
        mov     x5, 5
        mov     x6, 6
        mov     x7, 7
        mov     x8, 8
        mov     x9, 9
        mov     x10, 10
        
        // Make enough room on stack to store 3 64-bit registers (24 bytes)
        // Stack pointer must be a multiple of 16, so decrease by 32 instead of 24.
        // sub     sp, sp, 32
        // str     x8, [sp, 0]     // Store the extra registers on the stack.
        // str     x9, [sp, 8]     // SP should point to the first of these arguments.
        // str     x10, [sp, 16]   // Other arguments are stored at higher memory addresses.

        bl printf
        
        // add     sp, sp, 32      // Restore stack pointer to its value before storing registers

        mov     x0, 0
        ldp     fp, lr, [sp], 16
        ret
