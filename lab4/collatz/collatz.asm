define(N, X19)                          // Define some registers by more readable names.
define(ONE, X20)                        // X19-22 are chosen because is we call printf,
define(TWO, X21)                        // printf might change the contents of X0-18
define(THREE, X22)                      // X19-28 are safe to use

fmt: .string "%lu\n"

.global main                            
.balign 4                                        

main:
        stp     x29, x30, [sp, -16]!    // Function prologue
        mov     x29, sp                     

        // TODO: Initialize N, ONE, TWO, THREE

        adrp    X0, fmt
        add     X0, X0, :lo12:fmt
        mov     X1, N
        bl      printf                  // Print N

        // TODO: Insert branch instructions (e.g. b, b.cc) to properly structure the
        //       loop and if-else-statement
loop_body:
        // The loop begins here
if_cond:
        // TODO: Check if N is even or odd.
        // If you have not learned binary arithmetic in lectures yet, here is a hint
        // the instruction "and X23, N, 1" computes (N AND 1) and stores the result in X23.
        // (N AND 1) is 0 if N is even.
        // (N AND 1) is 1 if N is odd.
        and     X23, N, 1               // X23 = 1 if N is odd, or 0 is N is even
if_true:
        // TODO: If N is even, then divide N by 2
if_false:
        // TODO: If N is odd, then multiply N by 3 and add 1.
after_if:
        adrp    X0, fmt
        add     X0, X0, :lo12:fmt
        mov     X1, N
        bl      printf                  // Print N
loop_cond:
        // TODO: Loop again if n > 1
after_loop:
        mov     x0, 0                   // Exit with code 0
        ldp     x29, x30, [sp], 16      // Function epilogue
        ret                             
                                        
                                        




