#include <libopencm3/stm32/rcc.h>
#include <libopencm3/stm32/gpio.h>

#define RCC_LED1 RCC_GPIOC
#define PORT_LED1 GPIOC
#define PIN_LED1 GPIO13

int
main ()
{
    rcc_periph_clock_enable (RCC_LED1);
    gpio_set_mode (PORT_LED1, GPIO_MODE_OUTPUT_2_MHZ, GPIO_CNF_OUTPUT_PUSHPULL, PIN_LED1);
    gpio_set (PORT_LED1, PIN_LED1);

    while (1)
    {
        for (int i = 0; i < 200000; ++i)
            asm volatile ("nop");
        gpio_toggle (PORT_LED1, PIN_LED1);
    }
}
