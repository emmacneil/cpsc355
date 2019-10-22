// Example 3 - Callee-saved registers
// 
// Registers X19-X28 are "callee-saved" registers. This means that, by convention, functions
// that make use of these registers must make sure that, before the function returns, these
// registers contain the same values as when the function was called.

.balign 4
.global main

fp .req x29
lr .req x30

main :
        stp     fp, lr, [sp, -16]!
        mov     fp, sp

        mov     x19, 7  // Store two numbers in registers
        mov     x20, 11

        mov     x0, x19 // Pass these numbers as arguments to diff
        mov     x1, x20
        bl      diff
// After calling diff, X19 and X20 should still be 7 and 11, respectively.
// (If the str/ldr instructions in diff are commented out, then X19 will no longer be 7.)
        mov     x0, 0
        ldp     fp, lr, [sp], 16
        ret



// Compute the absolute value of the difference between two integers
// The integers are given in the first two parameter registers, X0 and X1.
// The result is return in X0.
// This function makes use of the callee-saved register X19, so it must make sure
// X19 is restored to whatever value it held before this function was called.
// (A better design would probably be for diff to use a different register.)
diff :
        stp     fp, lr, [sp, -16]!
        mov     fp, sp
        // str     x19, [sp, -16]!         // Save register X19 to restore it later.

        sub     x19, x0, x1             // Store X0 - X1 in X19
        b.mi    diff_end                // If X19 is negative, 
        neg     x19, x19                // then make it positive
diff_end:
        mov     x0, x19
        // ldr     x19, [sp], 16           // Restore register X19
        ldp     fp, lr, [sp], 16
        ret
