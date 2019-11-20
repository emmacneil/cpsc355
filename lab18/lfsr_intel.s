section .data

lfsr_state      dh      1

section .text
global  lfsr
lfsr :
        // Get address of lfsr_state from data section
        mov     eax, lfsr_state
        mov     eax, HWORD PTR [eax]

        // Load state into register
        ldrh    state_r, [x9]

        // XOR bits 10, 12, 13, and 15
        and     eax, 0xb400
        popcnt  ebx, eax
        and     ebx, 1
        
        // Left-shift state by 1 bit and add the bit to the end of the state
        lsh     eax, 1
        xor     eax, ebx

        // Now the state has been rotated right 31 bits,
        eor     state_r, state_r, bit_r
        
        // Store the state back into memory and return
        str     state_r, [x9]
        mov     w0, bit_r
        ret
