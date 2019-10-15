// Example 2 --- Caller-saved registers
// 
// Registers X8-X15 are "caller-saved" registers. A function is allowed to make use of these
// registers, but if it calls another function, that function may *also* make changes to these
// registers. Before calling another function, you should save these registers if you do not
// want to lose their contents.

fmt: .string "This is a test.\n"

.balign 4
.global main

fp .req x29
lr .req x30

// Store two numbers in registers X8 and X9, then call printf.
// printf might change these registers, so store the contents of X8 and X9 on the stack
// before calling printf, and load the contents from the stack after calling printf.
main :
        stp     fp, lr, [sp, -16]!
        mov     fp, sp

        mov     x8, 7                   // Store two numbers in registers
        mov     x9, 11

        stp     x8, x9, [sp, -16]!      // Save these numbers on the stack

        adrp    x0, fmt
        add     x0, x0, :lo12:fmt
        bl      printf                  // Call printf, changing the values of printf

        ldp     x8, x9, [sp], 16        // Load the saved numbers back into the registers

        mov     x0, 0
        ldp     fp, lr, [sp], 16
        ret
