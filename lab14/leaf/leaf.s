fmt:    .string "Hello, world!\n"
        fmt_sz = 14
        stdout_fd = 0
        syscall_write = 64

        .global main
        .balign 4

// Just calls func1, then exits.
main :
        stp     fp, lr, [sp, -16]!
        mov     fp, sp

        bl func1

        mov     x0, 0
        ldp     fp, lr, [sp], 16
        ret

// Just calls func2
func1 :
        stp     fp, lr, [sp, -16]!
        mov     fp, sp

        bl      func2
        
        ldp     fp, lr, [sp], 16
        ret
        
// Just calls func3
func2 :
        stp     fp, lr, [sp, -16]!
        mov     fp, sp

        bl      func3
        
        ldp     fp, lr, [sp], 16
        ret

// Prints a message to stdout using a system call.
// This is a leaf function, so we don't need to back up fp, lr
func3 :
        mov     x0, stdout_fd           // Tell kernel which file to write to ...
        ldr     x1, =fmt                // ... which string to write ...
        mov     x2, fmt_sz              // ... and size of string to be written.
        mov     x8, syscall_write       // System call number
        svc     0                       // Invoke system call (SVC = supervisor call)
        ret
        
