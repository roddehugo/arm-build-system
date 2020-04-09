#include <stdint.h>

typedef void (*vector_t) (void);

typedef struct
{
    uint32_t *stack;
    vector_t entry;
} vector_table_t;

void entry (void);
void halt (void);
void deadbeef (void);

extern uint32_t _stack;
extern uint32_t _data_loadaddr;
extern uint32_t _data;
extern uint32_t _edata;
extern uint32_t _ebss;

vector_table_t vector_table
__attribute__ ((section (".vectors"))) =
{
    .stack = &_stack,
    .entry = entry,
};

void
deadbeef (void)
{
    asm volatile ("ldr  r7, =0xdeadbeef");
}

void __attribute__((noreturn))
halt (void)
{
    asm volatile ("bkpt");
    while (1)
        ;
}

void __attribute__ ((naked))
entry (void)
{
    uint32_t *src = &_data_loadaddr;
    uint32_t *dst = &_data;
    while (dst < &_edata)
        *dst++ = *src++;
    while (dst < &_ebss)
        *dst++ = 0;

    deadbeef ();
    halt ();
}
