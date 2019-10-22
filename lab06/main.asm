// This program places the number 11485440 (0xaf4100) in a register (x19).
// It then right-shifts this number as much as possible without losing any of the non-zero bits.
// Afterwards, it left-shifts as much as possible without losing any non-zero bits.
// This is the same as dividing the number by its largest factor of 2,
// then multplying it by the largest possible power of 2 without overflowing a 64-bit register.

.balign 4
.global main

define(num_r, x19)
define(one_r, x20)
define(tmp_r, x21)

main:
        stp     x29, x30, [sp, -16]!
        mov     x29, sp

        mov     one_r, 1
        // Put 0xaf4100 in a register. This takes several instructions, because 0xaf4100 is a
        // 24-bit number and the MOV instruction can only move 16-bit values (or some larger
        // values if they have a very particular form).
        movz    num_r, 0xaf, lsl 16     // Stores 0xaf in num_r, then left-shifts it by 16 bits.
        mov     tmp_r, 0x4100
        add     num_r, num_r, tmp_r     // num_r is now 0xaf4100

        // The first loop divides out by the largest possible power of 2.
        // As long as the least significant bit of num_r is 0, we divide by 2.
        b loop1_cond
loop1:
        lsr     num_r, num_r, 1         // Divide by 2 (using right-shift operation)
loop1_cond:
        and     tmp_r, num_r, one_r     // Compute num_r AND 1
        cmp     tmp_r, 0                // Compare the result to 0
        b.eq    loop1                   // And loop again if the the result is equal to 0.
        
        // The second loop multiplies by the largest possible power of 2.
        // As long as the *most* significant bit of num_r is 0, we multiply by 2.
        // Start by left-shifting one_r so that it holds the 64-bit binary number
        // 10000000 00000000 ... 00000000
        lsl     one_r, one_r, 63
        b loop2_cond
loop2:
        lsl     num_r, num_r, 1         // Multiply by 2 (using left-shift operation)
loop2_cond:
        and     tmp_r, num_r, one_r     // Compute num_r AND (0b10000000...00000000)
        cmp     tmp_r, 0                // If the result is 0, then there is no 1 in num_r's most
        b.eq    loop2                   // significant position, so loop again.
        
        mov     x0, 0
        ldp     x29, x30, [sp], 16
        ret
