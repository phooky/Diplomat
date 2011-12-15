#define F_CPU 16000000UL  // 16 MHz
#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/sleep.h>
#include <util/delay.h>
#include <string.h>
#include <stdint.h>

#include "Configuration.hh"

void printSerial(char* pTxt) {
  while(*pTxt != '\0') {
    UCSR0A |= _BV(TXC0);
    UDR0 = *pTxt;
    while ((UCSR0A & _BV(TXC0)) == 0);
    pTxt++;
  }
}

void init()
{
  cli();
  initPins();
  printSerial((char*)"Initializing stamper.\n");
  _delay_ms(1200);
  //set_sleep_mode( SLEEP_MODE_IDLE );
  DDRB = _BV(5);
  sei();
}

int main( void )
{
  init();

  while (1) {
    PORTB = _BV(5);
    _delay_ms(100);
    PORTB = _BV(5);
    for (int i = 0; i < 12; i++) {
      setABCD(i);
      setP();
      _delay_us(15);
      clrP();
    }
    PORTB = 0;
  }
  return 0;
}
