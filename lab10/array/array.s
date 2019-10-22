// Constructs an array in stack memory containing the first 40 elements of the Fibonacci sequence.
// The Fibonacci sequence is the sequence of numbers
//
//      1, 1, 2, 3, 5, 8, 13, 21, 34, 55, ...,
//
// where the first two numbers are defined to be 1, and every subsequent number is the sum of the
// previous two.
//
// There are still some optimizations that could be done to this code. For example, we loop
// from i = 2 to i = 40, but in the body of the loop we must subtract 2 from i. It would likely
// be faster to loop from i = 0 to i = 38 and adjust the logic inside the loop accordingly.
//
// It would be faster to use a CPU register for the loop counter rather than a local variable on
// the stack. This program is frequently loading the loop counter from memory into a register when
// it is already in a register. However, for assignment 3, you are required to put all variables
// on the stack, so this is for demonstration.

        n_fibs   = 40                           // Number of Fibonacci numbers to compute
        fib_size = n_fibs*4                     // Size in bytes of array of Fibonacci numbers
        i_size   = 4                            // Size in bytes of loop counter, i
        fib_s    = 16                           // Offset from frame pointer of Fibonacci array
        i_s      = fib_s + fib_size             // Offset from frame pointer of loop counter
        var_size = fib_size + i_size            // Size in bytes of local variables
        alloc    = -(16 + var_size) & -16       // Amount by which to adjust stack pointer in main
        
        .global main
        .balign 4

main:
        // Store fp and lr and make room for local variables
        stp     fp, lr, [sp, alloc]!            
        mov     fp, sp

        // Initialize fib[0] = 1 and fib[1] = 1.
        // fib[0] and fib[1] are adjacent in memory, so both can be initialized at once with stp.
        mov     w8, 1
        stp     w8, w8, [fp, fib_s]

        // Initialize i = 2, then begin for loop
        mov     w8, 2
        str     w8, [fp, i_s]
        b       loop_test
loop_body:
        // Store (i - 2) in W8 and address of fib[0] in X9
        ldr     w8, [fp, i_s]
        sub     w8, w8, 2
        add     x9, fp, fib_s

        // Load fib[i-2] and fib[i-1] into registers W10 and W11, respectively.
        // The instruction "LDR W10, [X9, W8, SXTW 2]" does the following:
        //      Sign-extend W8 (from 32 bits to 64 bits)
        //      Left-shift W8 by 2 (i.e multiply by 4, the size in bytes of an element of fib[])
        //      Load into W10 the value at the memory address stored in (X9 + W8)
        // The C equivalent would be:
        //      W10 = *(X9 + (((long int)W8) << 2))
        ldr     w10, [x9, w8, sxtw 2]   // Load fib[i-2] into W10
        add     w8, w8, 1               // Increment i
        ldr     w11, [x9, w8, sxtw 2]   // Load fib[i-1] into W11

        // Add fib[i-2] + fib[i-1] and store on stack in fib[i]
        add     w10, w10, w11
        add     w8, w8, 1               // Increment i
        str     w10, [x9, w8, sxtw 2]

        // Increment the copy of i on the stack.
        ldr     w8, [fp, i_s]           // Load old value of i from stack
        add     w8, w8, 1               // Add 1 to it
        str     w8, [fp, i_s]           // Store it back on the stack
loop_test:
        // Load i into a register from memory.
        // Loop again if it is less than the number of array elements.
        ldr     w8, [fp, i_s]
        cmp     w8, n_fibs
        b.lt    loop_body

end_main:
        mov     x0, 0
        ldp     fp, lr, [sp], -alloc
        ret
