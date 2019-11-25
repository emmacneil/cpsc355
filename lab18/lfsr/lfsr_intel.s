section .data

lfsr_state      dw      1

section .text
global  lfsr

%define	state_r	r9d
%define	bit_r	r10d

lfsr :
        mov     state_r, [lfsr_state]	; Load state into a register

	mov 	bit_r, state_r		; Copy the state to another register
        and     bit_r, 0xb400		; AND the copy with a bitmask
        popcnt  bit_r, bit_r    	; Count the number of bits still on after masking
        and     bit_r, 1                ; New bit is determined by whether this is even or odd
        shl     state_r, 1		; Left shift state by 1
        xor     state_r, bit_r		; Add new bit to the end
        
	mov 	[lfsr_state], state_r	; Store new state back in memory
        mov     eax, bit_r		; Return the new bit
        ret
