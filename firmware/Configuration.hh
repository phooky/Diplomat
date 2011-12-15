#ifndef CONFIGURATION_H
#define CONFIGURATION_H

#include <avr/io.h>
#include <stdint.h>

// Pin mappings
// C1 - D
// C2 - C
// C3 - B
// C4 - A
// C5 - P

inline void initPins() {
  PORTC = 0;
  DDRC = _BV(1) | _BV(2) | _BV(3) | _BV(4) | _BV(5);
}

inline void setABCD(const uint8_t v) {
  PORTC = (v << 1) & (_BV(1) | _BV(2) | _BV(3) | _BV(4));
}

inline void setP() {
  PORTC |= _BV(5);
}

inline void clrP() {
  PORTC &= ~_BV(5);
}

// Steps per mm
#define STEPS_PER_MM 50

#endif // CONFIGURATION_H
