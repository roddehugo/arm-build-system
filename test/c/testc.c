#include <stdint.h>

typedef void (*vector_t) (void);

typedef struct
{
    uint32_t *initial_stack;
    vector_t reset_handler;
} vector_table_t;

/* ELF build id note section.
 * +----------------+
 * |     namesz     |   32-bit, size of "name" field
 * +----------------+
 * |     descsz     |   32-bit, size of "desc" field
 * +----------------+
 * |      type      |   32-bit, vendor specific "type"
 * +----------------+
 * |      name      |   "namesz" bytes, null-terminated string
 * +----------------+
 * |      desc      |   "descsz" bytes, binary data
 * +----------------+ */
typedef struct {
    uint32_t namesz;
    uint32_t descsz;
    uint32_t type;
    char data[];
} build_id_t;

void reset_handler (void);
void halt (void);
void deadbeef (void);
void print_build_id (void);

extern uint32_t _stack;
extern uint32_t _data_loadaddr;
extern uint32_t _data;
extern uint32_t _edata;
extern uint32_t _ebss;
extern const build_id_t _build_id;

vector_table_t vector_table
__attribute__ ((section (".vectors"))) =
{
    .initial_stack = &_stack,
    .reset_handler = reset_handler,
};

void
print_build_id (void)
{
    /* Description binary data comes after name. */
    const char *begin = &_build_id.data[_build_id.namesz];
    const char *end = &begin[_build_id.descsz];
    (void) end;
}

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
reset_handler (void)
{
    uint32_t *src = &_data_loadaddr;
    uint32_t *dst = &_data;
    while (dst < &_edata)
        *dst++ = *src++;
    while (dst < &_ebss)
        *dst++ = 0;

    deadbeef ();
    print_build_id ();
    halt ();
}
