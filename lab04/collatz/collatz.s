.global main                            
                                        

main:
        stp     x29, x30, [sp, -16]!    // Function prologue
        mov     x29, sp                     
        
        // Print n
loop_body:
if_cond:
        // Check if n is even
if_true:
        // If so, divide it by 2
if_false:
        // If not, triple and add 1
after_if:
        // Print n
loop_cond:
        // Loop again if n > 1
after_loop:

        mov     x0, 0                   // Exit with code 0
        ldp     x29, x30, [sp], 16      // Function epilogue
        ret                             
                                        
                                        




