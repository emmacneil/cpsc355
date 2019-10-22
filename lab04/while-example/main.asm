define(timer, X19)
fmt_int:        .string "%d, "
fmt_msg:        .string "lift off!\n"

        .global main
        .balign 4

main:
        stp     x29, x30, [sp, -16]!    // Function prologue
        mov     x29, sp

        // Count down from some number until 1.
        // Then print the message "lift off!"
        mov     timer, 100              // Initialize count-down timer with some number

        b       loop_cond
loop_body:
        adrp    x0, fmt_int
        add     x0, x0, :lo12:fmt_int
        mov     x1, timer
        bl      printf                  // Print the current timer
        sub     timer, timer, 1         // Subtract 1 from timer
loop_cond:
        cmp     timer,  1               // Compare timer to 1
        b.ge    loop_body               // If timer > 1, re-enter the loop
        
        adrp    x0, fmt_msg
        add     x0, x0, :lo12:fmt_msg
        bl      printf                  // Print "lift off!"

        mov     x0, 0                   // Return with exit code 0
        ldp     x29, x30, [sp], 16      // Function epilogue
        ret
