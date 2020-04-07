// Define attributes of our chip and assembly language in used.
.syntax unified
.cpu cortex-m3
.fpu softvfp
.thumb

// Global memory locations.
.global vectors
.global entry

// The actual vector table.
.type vectors, %object
vectors:
    .word _stack
    .word entry
.size vectors, .-vectors

// The entry point. Called on reset.
.type entry, %function
entry:
  // Set the stack pointer to the end of the stack.
  // The '_stack' value is defined in our linker script.
  LDR  r0, =_stack
  MOV  sp, r0

  // Set some dummy values. When we see these values
  // in our debugger, we'll know that our program
  // is loaded on the chip and working.
  LDR  r6, =0xdeadbeef
  MOVS r0, #0
  BKPT
  loop:
    // Add 1 to register 'r0'.
    ADDS r0, r0, #1
    // Loop back.
    B    loop
.size entry, .-entry
