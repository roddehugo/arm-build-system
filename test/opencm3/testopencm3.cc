#include <libopencm3/stm32/rcc.h>
#include <libopencm3/stm32/gpio.h>

#define LEDRCC (RCC_GPIOC)
#define LEDPORT (GPIOC)
#define LEDPIN (GPIO13)
#define GPIO_MODE (GPIO_MODE_OUTPUT_2_MHZ)
#define GPIO_PUPD (GPIO_CNF_OUTPUT_PUSHPULL)

int
main ()
{
    rcc_periph_clock_enable (LEDRCC);
    gpio_set_mode (LEDPORT, GPIO_MODE, GPIO_PUPD, LEDPIN);
    gpio_set (LEDPORT, LEDPIN);

    while (1)
    {
        for (int i = 0; i < 200000; ++i)
            asm volatile ("nop");
        gpio_toggle (LEDPORT, LEDPIN);
    }

    return 0;
}
