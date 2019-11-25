        .data
lfsr_state:
        .hword  1

        .text
        .balign 4
        .global lfsr
state_r .req    w10
bit_r   .req    w11

lfsr :
        adrp    x9, lfsr_state		// Get address of lfsr_state from data section
        add     x9, x9, :lo12:lfsr_state
        ldrh    state_r, [x9]		// Load state into register
        
        ror     state_r, state_r, 10	// A bunch of bitwise manipulation 
        mov     bit_r, state_r		// to XOR bits 10, 12, 13, 15 of the state
        ror     state_r, state_r, 2
        eor     bit_r, state_r, bit_r
        ror     state_r, state_r, 1
        eor     bit_r, state_r, bit_r
        ror     state_r, state_r, 2
        eor     bit_r, state_r, bit_r
        and     bit_r, bit_r, 1
        
        ror     state_r, state_r, 16 	// Now the state has been left-rotated 1 bit.
        eor     state_r, state_r, bit_r // Add the bit to the end of the state
       
        str     state_r, [x9]		// Store the state back into memory and return
        mov     w0, bit_r		// Return the new bit
        ret
