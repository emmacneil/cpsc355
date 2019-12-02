// int main(int argc, char * argv[])
//
//   argc : the number of arguments to the program
//   argv : an array of arguments
//
// Prints out the number of arguments, prints out argv (i.e. its address, not its contents),
// then calls array_sum() to interpret the arguments as integers, add them together, and
// print their sum
        .text
fmt_argc:       .string "argc = %d\n"
fmt_argv:       .string "argv = %p\n"
        .balign 4
        .global main
argc_r  .req    w19
argv_r  .req    x20
main :  stp     fp, lr, [sp, -16]!
        mov     fp, sp

        // argc and argv are in registers W0 and X1.
        // Move them to caller-saved registers so they are not overwritten by printf.
        mov     argc_r, w0
        mov     argv_r, x1

        // Print out argc
        adrp    x0, fmt_argc
        add     x0, x0, :lo12:fmt_argc
        mov     w1, argc_r
        bl      printf
        
        // Print out argv
        adrp    x0, fmt_argv
        add     x0, x0, :lo12:fmt_argv
        mov     x1, argv_r
        bl      printf

        // If arguments have been given to the program (i.e. if argc > 1),
        // then interpret them as integers and add them.
        // This is done via a subroutine.
        mov     x0, argv_r
        add     x0, x0, 8
        mov     w1, argc_r
        sub     w1, w1, 1
        bl      array_sum

        mov     x0, 0
        ldp     fp, lr, [sp], 16
        ret

// void array_sum(char* arr[], int len)
//
//   arr : an array of strings.
//   len : the length of arr
//
//   Converts the strings in arr to integers and prints their sum.
fmt_first:      .string "%d"
fmt_other:      .string " + %d"
fmt_sum:        .string " = %d\n"
i_r     .req    w19
alloc = -(16 + 4*2 + 8) & -16
len_s = 16
sum_s = 20
arr_s = 24
        .balign 4
array_sum :
        stp     fp, lr, [sp, alloc]!    // Backup FP, LR
        mov     fp, sp

        str     x0, [fp, arr_s]         // Backup arguments on stack
        str     w1, [fp, len_s]
        str     wzr, [fp, sum_s]        // Set sum to 0.
        eor     i_r, i_r, i_r           // Clear register i_r
        b       .L3

.L0:    ldr     x0, [fp, arr_s]         // Get the address of arr, stored on the stack
        ldr     x0, [x0, i_r, sxtw 3]   // Load the address of the string arr[i] into x0
        bl      atoi                    // Convert arr[i] into an integer
        mov     w1, w0                  // Copy the converted integer from w0 to w1. It needs
                                        // to be in this registers later when we print it.
        ldr     w0, [fp, sum_s]         // Update the sum, stored on the stack
        add     w0, w0, w1
        str     w0, [fp, sum_s]

        // Load a format string to print an integer. The format string is different for the
        // first iteration of the loop.
        cmp     i_r, 0                  // If this is not the first iteration
        b.ne    .L1                     // Then print 'fmt_other'
        adrp    x0, fmt_first           // Otherwise, print 'fmt_first'
        add     x0, x0, :lo12:fmt_first
        b       .L2
.L1:    adrp    x0, fmt_other
        add     x0, x0, :lo12:fmt_other
.L2:    bl      printf                  // Print.

        add     i_r, i_r, 1             // Update loop counter
.L3:    ldr     w9, [fp, len_s]         // Load length of array from stack
        cmp     i_r, w9                 // And compare loop counter to length
        b.lt    .L0                     // Loop again, if counter < length

        // Print the sum.
        adrp    x0, fmt_sum
        add     x0, x0, :lo12:fmt_sum
        ldr     w1, [fp, sum_s]
        bl      printf

        ldp     fp, lr, [sp], -alloc    // Restore FP, LR
        ret
