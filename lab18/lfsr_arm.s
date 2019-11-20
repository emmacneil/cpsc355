        .data
lfsr_state:
        .hword  1

        .text
        .balign 4
        .global lfsr
state_r .req    w10
bit_r   .req    w11
lfsr :
        // Get address of lfsr_state from data section
        adrp    x9, lfsr_state
        add     x9, x9, :lo12:lfsr_state

        // Load state into register
        ldrh    state_r, [x9]

        // A bunch of bitwise manipulation to XOR bits 10, 12, 13, 15 of the state
        ror     state_r, state_r, 10
        mov     bit_r, state_r
        ror     state_r, state_r, 2
        eor     bit_r, state_r, bit_r
        ror     state_r, state_r, 1
        eor     bit_r, state_r, bit_r
        ror     state_r, state_r, 2
        eor     bit_r, state_r, bit_r
        and     bit_r, bit_r, 1
        
        ror     state_r, state_r, 16

        // Now the state has been rotated right 31 bits,
        // equivalently, left-shifted 1 bit.
        // Add the bit to the end of the state
        eor     state_r, state_r, bit_r
        
        // Store the state back into memory and return
        str     state_r, [x9]
        mov     w0, bit_r
        ret
