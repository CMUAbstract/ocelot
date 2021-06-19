#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>
#include <msp430.h>
//#include <libmspware/driverlib.h>
//#include <libalpaca/alpaca.h>
//#include <libwispbase/wisp-base.h>
#include "test_lib.h"
#include <librustic/checkpoint.h>

#include <libcapybara/capybara.h>
#include <libcapybara/power.h>
#include <libcapybara/reconfig.h>
#include <libcapybara/board.h>


#include <libmspbuiltins/builtins.h>
#include <libio/console.h>
#include <libmsp/mem.h>
#include <libmsp/periph.h>
#include <libmsp/clock.h>
#include <libmsp/watchdog.h>
#include <libmsp/gpio.h>

#define MEASURE 1

__nv unsigned count = 0;

capybara_task_cfg_t pwr_configs[1] = {
  CFG_ROW(0, CONFIGD, LOW, NA),
};

#define FAILURE 0

/*apps will be based around a main stub
This stub needs to:
(1) call capybara_init()
(2) call entry 
(3) call the initial rust function, named app
*/
int main() {
  
  capybara_init();
  
  entry();
    
  //fall through only if no checkpoint taken in rustland yet
  app();
     
  return 0;
}

void gpioTwiddle(){
    P1OUT |= BIT0;
    P1DIR |= BIT0;
    P1OUT &= ~BIT0;

    P1OUT |= BIT1;
    P1DIR |= BIT1;
    P1OUT &= ~BIT1;

}

