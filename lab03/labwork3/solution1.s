.global main
.balign 4

main:
        stp x29, x30, [sp, -16]!        // Function prologue
        mov x29, sp

        mov X1, 7                       // Store the value 7 in X1
        mov X1, 21                      // Store the value 21 in X2
        
        // The following computes X1*X1 - 2*X1*X2 + X2*X2 the long way
        // The three terms are stored in registers X4, X5, X6
        // Then we add/subtract them.
        mul X4, X1, X1                  // Compute X4 = X1*X1
        
        mul X5, X1, X2                  // Compute X5 = X1*X2
        add X5, X5, X5                  // and     X5 = 2*X5
        
        mul X6, X2, X2                  // Compute X6 = X2*X2

        mov X3, X4                      // X3 is X1*X1
        sub X3, X5                      // X3 is now X1*X1 - 2*X1*X2
        sub X3, X6                      // X3 is now X1*X1 - 2*X1*X2 - X2*X2

BP1:    // Break at this breakpoint and inspect registers to ensure X3 is correct.
        
        mov X0, 0                       // Exit with code 0
        ldp x29, x30, [sp], 16          // Function epilogue
        ret
