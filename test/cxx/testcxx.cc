#include <cstdint>

typedef void (*vector_t) (void);

struct vector_table_t
{
    uint32_t *initial_stack;
    vector_t reset_handler;
};

extern "C" void reset_handler ();
extern "C" void halt ();

extern uint32_t _stack;
extern uint32_t _data_loadaddr;
extern uint32_t _data;
extern uint32_t _edata;
extern uint32_t _ebss;
extern uint32_t __preinit_array_start;
extern uint32_t __preinit_array_end;
extern uint32_t __init_array_start;
extern uint32_t __init_array_end;
extern uint32_t __fini_array_start;
extern uint32_t __fini_array_end;

vector_table_t vector_table
__attribute__ ((section (".vectors"))) =
{
    .initial_stack = &_stack,
    .reset_handler = reset_handler,
};

struct Beef
{
    // Constructor should be called when entering scope.
    Beef () { asm volatile ("ldr  r7, =0xbeefbabe"); }
    // Destructor should be called when exiting scope.
    ~Beef () { asm volatile ("ldr  r8, =0xdeadbeef"); }
};

struct Cafe
{
    // Constructor should be called upon initialization.
    Cafe () { asm volatile ("ldr  r9, =0xcafebabe") ; }
    // Destructor should not be called unless registered with __cxa_atexit;
    ~Cafe () { asm volatile ("ldr  r10, =0xdeadcafe"); }
};

static Cafe c;

extern "C" void __attribute__((noreturn))
halt (void)
{
    asm volatile ("bkpt");
    while (1)
        ;
}

extern "C" void __attribute__ ((naked))
reset_handler ()
{
    uint32_t *src = &_data_loadaddr;
    uint32_t *dst = &_data;
    while (dst < &_edata)
        *dst++ = *src++;
    while (dst < &_ebss)
        *dst++ = 0;

    uint32_t *fp;
    fp = &__preinit_array_start;
    while (fp < &__preinit_array_end)
        reinterpret_cast<void (*) ()> (*fp++) ();
    fp = &__init_array_start;
    while (fp < &__init_array_end)
        reinterpret_cast<void (*) ()> (*fp++) ();

    {
        Beef b;
    }

    fp = &__fini_array_start;
    while (fp < &__fini_array_end)
        reinterpret_cast<void (*) ()> (*fp++) ();

    halt ();
}
