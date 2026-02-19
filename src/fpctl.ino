/*
  fpctl

  Interface Airbus A320 cockpit to FlightGear flight sim using ESP32.

  The controller appears on the USB bus as both a HID gamepad device and 
  a serial port. Most of the inputs to FlightGear are handled as joystick 
  axes and buttons. The other inputs are implemented by sending nasal 
  commands over the serial port. We also read from the serial port to get 
  outputs from a custom FlightGear protocol to update the FCU displays 
  and indicators.

  https://github.com/swapdisk/fpctl
  
  (c) 2026 Bob Mader
  MIT License

*/

// USB and Gamepad libraries
#include "USB.h"
#include "USBHIDGamepad.h"
USBHIDGamepad gp;

// OLED libraries
#include <SPI.h>
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>

// SSD1306 I2C pins and settings
#define SCREEN_SDA 1
#define SCREEN_SCL 2
#define OLED_RESET -1
#define SCREEN_WIDTH 128
#define SCREEN_HEIGHT 32
#define SCREEN_ADDR 0x3C  // OLED displays all at the same address
#define SWITCH_ADDR 0x70  // PCA9548A I2C switch address
Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, OLED_RESET);

// Pins for stateful switches
#define PIN_GEAR 3
#define PIN_UNITS 0  // Sadly, this is also the boot pin

// Multi-button resistor ladder magic
// https://ignorantofthings.com/pushing-adc-limits-with-the-perfect-multi-button-input-resistor-ladder/
#define BUTTONS 8
#define RESOLUTION 4095
#define PIN_RL1 4
#define PIN_RL2 8
#define PIN_RL3 6

// Potentiometer input pins
#define PIN_JS0X 7
#define PIN_JS0Y 15
#define PIN_JS1X 16
#define PIN_JS1Y 17
#define PIN_FLAPS 18

// LED indicator output pins
#define PIN_LOC 46
#define PIN_ATHR 9
#define PIN_AP1 10
#define PIN_AP2 11
#define PIN_EXPED 12
#define PIN_APPR 13
#define PIN_VIEW 14
#define PIN_WARN 48
#define PIN_CAUT 47

// Speaker output pin
#define PIN_SPEAKER 38

// Encoder pin assignments
#define PIN_ENC1A 42
#define PIN_ENC1B 41
#define PIN_ENC2A 40
#define PIN_ENC2B 39
#define PIN_ENC3A 21
#define PIN_ENC3B 37
#define PIN_ENC4A 36
#define PIN_ENC4B 35
#define PIN_ENC5A 5
#define PIN_ENC5B 45

// Setup encoders
// https://github.com/mathertel/RotaryEncoder
// LatchMode::FOUR3 is 4 steps per latch or 24 steps per turn
// LatchMode::TWO03 is 2 steps per latch or 48 steps per turn
#include <RotaryEncoder.h>
RotaryEncoder encoderSPD(PIN_ENC1A, PIN_ENC1B, RotaryEncoder::LatchMode::TWO03);
RotaryEncoder encoderHDG(PIN_ENC2A, PIN_ENC2B, RotaryEncoder::LatchMode::TWO03);
RotaryEncoder encoderALT(PIN_ENC3A, PIN_ENC3B, RotaryEncoder::LatchMode::TWO03);
RotaryEncoder encoderVS(PIN_ENC4A, PIN_ENC4B, RotaryEncoder::LatchMode::TWO03);
RotaryEncoder encoderTrim(PIN_ENC5A, PIN_ENC5B, RotaryEncoder::LatchMode::TWO03);

// Magic encoder values to force display update while not sending nasal command
const int dontSendSPD = 0;
const int dontSendHDG = 0;
const int dontSendALT = 0;
const int dontSendVS = 999;

// Set encoder position default values
int encoderSPDPos = 100;
int encoderHDGPos = 360;
int encoderALTPos = 100;
int encoderVSPos = 0;
int encoderTrimPos = 0;

// Serial read buffer
const int maxBuffer = 128;
char serialBuffer[maxBuffer];
int bufferIndex = 0;

// Loop counter and timers
unsigned long loopCount = 0;
unsigned long loopDiff = 0;
unsigned long currentTime = 0;
unsigned long lastAct = 0;
unsigned long prevTime = 0;

// Display timeout values
unsigned long dispDimMillis = 300000;   // 5 minutes
unsigned long dispOffMillis = 1200000;  // 20 minutes

// Potentiometer read timer
const int potMillis = 100;
unsigned long whenPot = 0;

// Stateful switch vars
int oldGear = -1;
int oldUnits = -1;

// Flaps position
int oldFlapsPos = -1;

// FCU modes
bool ktsMachMode = false;
bool trkFpaMode = false;
bool unitsMode = false;
bool vsDashes = true;
bool warnBlink = false;

// Internal modes
bool debugMode = false;
bool viewMode = false;
unsigned long lastViewPress = 0;

// Resistor ladder vars
// old* used for detecting button change
int oldRL1 = -1;
int oldRL2 = -1;
int oldRL3 = -1;
// prev* used for debounce and button release
int prevRL1 = 0;
int prevRL2 = 0;
int prevRL3 = 0;

// Debounce timer vars
unsigned long whenRL1 = 0;
unsigned long whenRL2 = 0;
unsigned long whenRL3 = 0;
const unsigned long bounceWait = 50;

// Mapping of RL buttons to HID gamepad buttons
const int buttonMap[24] = {
  24,  // R1-1 SPD pull
  25,  // R1-2 HDG pull
  26,  // R1-3 ALT pull
  27,  // R1-4 VS pull
  28,  // R1-5 SPD push
  29,  // R1-6 HDG push
  30,  // R1-7 ALT push
  31,  // R1-8 VS push
  12,  // R2-1 A/THR
  13,  // R2-2 LOC
  14,  // R2-3 SPD/MACH
  15,  // R2-4 AP1
  16,  // R2-5 AP2
  17,  // R2-6 HDG/TRK
  18,  // R2-7 EXPED
  19,  // R2-8 APPR
  20,  // R3-1 METRIC
  21,  // R3-2 MAST WARN
  22,  // R3-3 MAST CAUT
  -1,  // R3-4 VIEW (not sent)
  23,  // R3-5 TO CONFIG
  -1,  // R3-6 TRIM (not sent)
  -1,  // R3-7 JS0 (not sent)
  -1   // R3-8 JS1 (not sent)
};

// Switch PCA9548A channel to select OLED
void selectOLED(uint8_t i) {
  if (i > 7) return;
  Wire.beginTransmission(SWITCH_ADDR);
  Wire.write(1 << i);
  Wire.endTransmission();
}

// Read joystick and return axis value
int scaleAxis(uint8_t pin) {
  int reading = analogRead(pin);

  // Convert 12-bit ADC to 8-bit HID gamepad axis
  return (reading / 16) - 128;
}

// Flaps potentiometer magic numbers
const int flapsMagic[] = { 3600, 3000, 2500, 2050 };
const int maxFlapsPos = 4;

// Read flaps control and return flaps setting
int getFlapsPos(uint8_t pin) {
  int reading = analogRead(pin);

  // Loop through flaps detents
  for (int i = 0; i < maxFlapsPos; i++) {
    if (reading > flapsMagic[i]) {
      return i;
    }
  }

  // Else, we are at full flaps
  return maxFlapsPos;
}

// Read resistor ladder pin and return button index
int getButton(uint8_t pin) {
  int reading = analogRead(pin);
  float stepSize = RESOLUTION / (float)BUTTONS;

  // Use rounding to calculate button index
  int buttonIndex = (int)((reading + (stepSize / 2.0)) / stepSize) + 1;

  // Index higher than our button count means no button pressed
  if (buttonIndex > BUTTONS) return 0;

  return buttonIndex;
}

// Sound for encoder steps
void click() {
  tone(PIN_SPEAKER, 1800, 4);
}

// Sound for button press
void boop() {
  tone(PIN_SPEAKER, 144, 24);
}

// Seven-segment digit mapping
//   +-a-+
//   f   b
//   +-g-+
//   e   c
//   +-d-+
const int segmentMap[13][8] = {
  // a, b, c, d, e, f, g, +
  { 1, 1, 1, 1, 1, 1, 0, 0 },  // 0
  { 0, 1, 1, 0, 0, 0, 0, 0 },  // 1
  { 1, 1, 0, 1, 1, 0, 1, 0 },  // 2
  { 1, 1, 1, 1, 0, 0, 1, 0 },  // 3
  { 0, 1, 1, 0, 0, 1, 1, 0 },  // 4
  { 1, 0, 1, 1, 0, 1, 1, 0 },  // 5
  { 1, 0, 1, 1, 1, 1, 1, 0 },  // 6
  { 1, 1, 1, 0, 0, 0, 0, 0 },  // 7
  { 1, 1, 1, 1, 1, 1, 1, 0 },  // 8
  { 1, 1, 1, 1, 0, 1, 1, 0 },  // 9
  { 0, 0, 0, 0, 0, 0, 1, 0 },  // - (10)
  { 0, 0, 0, 0, 0, 0, 1, 1 },  // + (11)
  { 0, 0, 1, 1, 1, 0, 1, 0 }   // o (12)
};

// Write up to 3-digit number
void writeDigits(Adafruit_SSD1306 &d, uint8_t xCursor, uint8_t yCursor, uint8_t space, int digit, uint8_t color, bool showZero) {
  digit = abs(digit);
  int segmentMap[] = { digit / 100 % 10, digit / 10 % 10, digit % 10 };
  if (digit > 99 || showZero) {
    writeDigit(d, xCursor, yCursor, segmentMap[0], color);
  }
  if (digit > 9 || showZero) {
    writeDigit(d, xCursor + space, yCursor, segmentMap[1], color);
  }
  writeDigit(d, xCursor + (space * 2), yCursor, segmentMap[2], color);
}

// Write one digit
void writeDigit(Adafruit_SSD1306 &d, uint8_t xCursor, uint8_t yCursor, int digit, uint8_t color) {
  for (uint8_t i = 0; i < 8; i++) {
    bool seg = segmentMap[digit][i];
    // if seg_on is true draw segment
    if (seg) {
      switch (i) {
        case 0:
          d.fillRoundRect(2 + xCursor, 0 + yCursor, 11, 3, 2, color);  // a
          break;
        case 1:
          d.fillRoundRect(12 + xCursor, 2 + yCursor, 3, 12, 2, color);  // b
          break;
        case 2:
          d.fillRoundRect(12 + xCursor, 14 + yCursor, 3, 12, 2, color);  // c
          break;
        case 3:
          d.fillRoundRect(2 + xCursor, 26 + yCursor, 11, 3, 2, color);  // d
          break;
        case 4:
          d.fillRoundRect(0 + xCursor, 14 + yCursor, 3, 12, 2, color);  // e
          break;
        case 5:
          d.fillRoundRect(0 + xCursor, 2 + yCursor, 3, 12, 2, color);  // f
          break;
        case 6:
          d.fillRoundRect(2 + xCursor, 13 + yCursor, 11, 3, 2, color);  // g
          break;
        case 7:
          d.fillRoundRect(6 + xCursor, 6 + yCursor, 3, 6, 2, color);   // plus top
          d.fillRoundRect(6 + xCursor, 17 + yCursor, 3, 6, 2, color);  // plus bottom
          break;
      }
      seg = false;
    }
  }
}

// Run initial setup
void setup() {
  // Set up serial port
  Serial.begin(115200);
  while (! Serial) delay(10);
  Serial.printf("\n");
  Serial.printf("Starting setup. (%d)\n", millis());

  // Set up input for stateful switches
  pinMode(PIN_GEAR, INPUT_PULLUP);
  pinMode(PIN_UNITS, INPUT_PULLUP);

  // Set up input pins for resitor ladders
  pinMode(PIN_RL1, INPUT);
  pinMode(PIN_RL2, INPUT);
  pinMode(PIN_RL3, INPUT);

  // Set up input pins for other A/D inputs
  pinMode(PIN_JS0X, INPUT);
  pinMode(PIN_JS0Y, INPUT);
  pinMode(PIN_JS1X, INPUT);
  pinMode(PIN_JS1Y, INPUT);
  pinMode(PIN_FLAPS, INPUT);

  // Set up LED pins
  pinMode(PIN_LOC, OUTPUT);
  pinMode(PIN_ATHR, OUTPUT);
  pinMode(PIN_AP1, OUTPUT);
  pinMode(PIN_AP2, OUTPUT);
  pinMode(PIN_EXPED, OUTPUT);
  pinMode(PIN_APPR, OUTPUT);
  pinMode(PIN_VIEW, OUTPUT);
  pinMode(PIN_WARN, OUTPUT);
  pinMode(PIN_CAUT, OUTPUT);

  // Set up SPEAKER pin
  pinMode(PIN_SPEAKER, OUTPUT);

  // Lamp test on
  Serial.printf("Lamp test on. (%d)\n", millis());
  digitalWrite(PIN_LOC, HIGH);
  digitalWrite(PIN_ATHR, HIGH);
  digitalWrite(PIN_AP1, HIGH);
  digitalWrite(PIN_AP2, HIGH);
  digitalWrite(PIN_EXPED, HIGH);
  digitalWrite(PIN_APPR, HIGH);
  digitalWrite(PIN_VIEW, HIGH);
  digitalWrite(PIN_WARN, HIGH);
  digitalWrite(PIN_CAUT, HIGH);

  // USB gamepad initialization
  Serial.printf("Initializing USB. (%d)\n", millis());
  gp.begin();
  USB.begin();

  // Initialize for I2C
  Serial.printf("Initializing I2C. (%d)\n", millis());
  Wire.begin(SCREEN_SDA, SCREEN_SCL);

  // Initialize FDU encoder settings
  Serial.printf("Initializing encoders. (%d)\n", millis());
  encoderSPD.setPosition(encoderSPDPos);
  encoderHDG.setPosition(encoderHDGPos);
  encoderALT.setPosition(encoderALTPos);
  encoderVS.setPosition(encoderVSPos);

  // Force display refresh on first loop
  encoderSPDPos = dontSendSPD;
  encoderHDGPos = dontSendHDG;
  encoderALTPos = dontSendALT;
  encoderVSPos = dontSendVS;

  // Initialize OLED I2C and all pixels on test
  Serial.printf("Initializing OLED displays. (%d)\n", millis());
  for (uint8_t s = 0; s < 5; s++) {
    selectOLED(s);
    display.begin(SSD1306_SWITCHCAPVCC, SCREEN_ADDR);  // initialize OLED I2C
    display.clearDisplay();
    display.fillRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, WHITE);
    display.display();
  }

  // Wake up beep
  Serial.printf("Wake up beep. (%d)\n", millis());
  tone(PIN_SPEAKER, 2000, 100);

  // Lamp test off
  delay(1500);
  digitalWrite(PIN_LOC, LOW);
  digitalWrite(PIN_ATHR, LOW);
  digitalWrite(PIN_AP1, LOW);
  digitalWrite(PIN_AP2, LOW);
  digitalWrite(PIN_EXPED, LOW);
  digitalWrite(PIN_APPR, LOW);
  digitalWrite(PIN_VIEW, LOW);
  digitalWrite(PIN_CAUT, LOW);
  digitalWrite(PIN_WARN, LOW);

  // OLED pixel test off
  for (uint8_t s = 0; s < 5; s++) {
    selectOLED(s);
    display.clearDisplay();
    display.display();
  }

  // Block waiting for gear lever down
  Serial.printf("Checking for gear lever down. (%d)\n", millis());
  while (digitalRead(PIN_GEAR)) {
    // Display message to user
    selectOLED(0);
    display.clearDisplay();
    display.setTextSize(2);
    display.setTextColor(WHITE);
    display.setCursor(0, 0);
    display.printf("Move gear\nlever --->\n");
    display.display();
    digitalWrite(PIN_WARN, HIGH);
    delay(250);

    // Blink message while waiting
    display.clearDisplay();
    display.display();
    digitalWrite(PIN_WARN, LOW);
    delay(250);
  }

  Serial.printf("Setup done; starting main loop. (%d)\n", millis());
}

// Check for reboot/debug commands
void handleSystemInputs() {
  // Long press EXPED to reboot
  if (oldRL2 == 7 && whenRL2 == -1 && currentTime - lastAct > 2000) {
    ESP.restart();
  }

  // Long press LOC to toggle debug output
  if (oldRL2 == 2 && whenRL2 == -1 && currentTime - lastAct > 2000) {
    lastAct = currentTime;
    debugMode = ! debugMode;
  }
}

// Do stateful switches and master warning blink
void handleSwitchesAndLEDs() {
  // Throttled to once per 300 loops
  if (loopCount % 300 == 0) {
    // Get stateful button values
    int newGear = digitalRead(PIN_GEAR);
    int newUnits = digitalRead(PIN_UNITS);

    // Handle gear event
    if (oldGear != newGear) {
      lastAct = currentTime;

      if (newGear) {
        Serial.printf("controls.gearDown(-1);\n");
        if (oldGear != -1) tone(PIN_SPEAKER, 54, 85);
      } else {
        Serial.printf("controls.gearDown(1);\n");
        if (oldGear != -1) tone(PIN_SPEAKER, 42, 85);
      }

      oldGear = newGear;
    }

    // Handle units event
    if (oldUnits != newUnits) {
      lastAct = currentTime;

      if (newUnits) {
        Serial.printf("setprop('it-autoflight/config/altitude-dial-mode', 0);\n");
        if (oldUnits != -1) tone(PIN_SPEAKER, 1500, 8);
      } else {
        Serial.printf("setprop('it-autoflight/config/altitude-dial-mode', 1);\n");
        if (oldUnits != -1) tone(PIN_SPEAKER, 1650, 8);
      }

      unitsMode = newUnits;
      oldUnits = newUnits;
    }

    // Blink master warning LED at 2 Hz
    if (warnBlink && currentTime % 500 > 250) {
      digitalWrite(PIN_WARN, HIGH);
    } else {
      digitalWrite(PIN_WARN, LOW);
    }
  }
}

// Read analog axis and flaps values
void handleAnalogControls() {
  // Throttled by potMillis
  if (currentTime - whenPot > potMillis) {
    // Read joysticks and send axis events
    if (viewMode) {
      gp.leftTrigger(scaleAxis(PIN_JS0X));
      gp.rightTrigger(scaleAxis(PIN_JS0Y));
    } else {
      gp.leftStick(scaleAxis(PIN_JS0X), scaleAxis(PIN_JS0Y));
    }
    gp.rightStick(scaleAxis(PIN_JS1X), scaleAxis(PIN_JS1Y));

    // Read flaps potentiometer
    int newFlapsPos = getFlapsPos(PIN_FLAPS);

    // Handle flaps change
    if (oldFlapsPos != newFlapsPos) {
      lastAct = currentTime;

      // Send nasal command
      Serial.printf("pts.Controls.Flight.flaps.setValue(%.1f);\n", 0.2 * newFlapsPos);

      // Flaps sound
      if (oldFlapsPos != -1) {
        if (newFlapsPos > oldFlapsPos) {
          tone(PIN_SPEAKER, 1200, 8);
        } else {
          tone(PIN_SPEAKER, 1100, 8);
        }
      }
      
      oldFlapsPos = newFlapsPos;
    }

    whenPot = currentTime;
  }
}

// Process button press events
void handleResistorLadders() {
  // Throttled to once per 8 loops
  if (loopCount % 8 == 0) {
    int newRL1 = getButton(PIN_RL1);
    int newRL2 = getButton(PIN_RL2);
    int newRL3 = getButton(PIN_RL3);

    // Detect change and set bounce timers
    if (oldRL1 != newRL1) { whenRL1 = currentTime + bounceWait; oldRL1 = newRL1; }
    if (oldRL2 != newRL2) { whenRL2 = currentTime + bounceWait; oldRL2 = newRL2; }
    if (oldRL3 != newRL3) { whenRL3 = currentTime + bounceWait; oldRL3 = newRL3; }

    // Process RL1 buttons
    if (whenRL1 < currentTime) {
      lastAct = currentTime;
      
      // Send button event
      if (newRL1 > 0) {
        (buttonMap[newRL1 - 1] >= 0) && gp.pressButton(buttonMap[newRL1 - 1]);
        boop();
      } else {
        (buttonMap[prevRL1 - 1] >= 0) && gp.releaseButton(buttonMap[prevRL1 - 1]);
      }

      // Remember for button release
      prevRL1 = newRL1;

      // Reset timer
      whenRL1 = -1;
    }

    // Process RL2 buttons
    if (whenRL2 < currentTime) {
      lastAct = currentTime;

      // Send button event
      if (newRL2 > 0) {
        (buttonMap[newRL2 + 7] >= 0) && gp.pressButton(buttonMap[newRL2 + 7]);
        boop();
      } else {
        (buttonMap[prevRL2 + 7] >= 0) && gp.releaseButton(buttonMap[prevRL2 + 7]);
      }

      // Handle speed mode change
      if (newRL2 == 3) {
        ktsMachMode = !ktsMachMode;
        encoderSPDPos = dontSendSPD;
        encoderSPD.setPosition(100);
      }

      // Handle TRK/FPA mode change
      if (newRL2 == 6) {
        trkFpaMode = !trkFpaMode;
        encoderHDGPos = dontSendHDG;
        encoderVSPos = dontSendVS;
        vsDashes = true;
      }

      // Remember for button release
      prevRL2 = newRL2;

      // Reset timer
      whenRL2 = -1;
    }

    // Process RL3 buttons
    if (whenRL3 < currentTime) {
      lastAct = currentTime;

      // Send button event
      if (newRL3 > 0) {
        (buttonMap[newRL3 + 15] >= 0) && gp.pressButton(buttonMap[newRL3 + 15]);
        boop();
      } else {
        (buttonMap[prevRL3 + 15] >= 0) && gp.releaseButton(buttonMap[prevRL3 + 15]);
      }

      // Handle view mode change
      if (newRL3 == 4) {
        if (currentTime - lastViewPress < 500) { // double press resets view
          // Send nasal command
          Serial.printf("view.setViewByIndex(0);view.resetViewDir();view.resetFOV();view.increase(20);\n");
        }
        viewMode = !viewMode;
        digitalWrite(PIN_VIEW, viewMode);
        lastViewPress = currentTime;
      }

      // Handle cycle view button
      if (viewMode && newRL3 == 6) {
        // Send nasal command
        Serial.printf("view.stepView(1);\n");
      }

      // Remember for button release
      prevRL3 = newRL3;

      // Reset timer
      whenRL3 = -1;
    }
  }
}

// Tick rotary encoders
void handleEncoders() {
  // Ticks unthrottled for precision
  encoderSPD.tick();
  encoderHDG.tick();
  encoderALT.tick();
  encoderVS.tick();
  encoderTrim.tick();

  // Read encoder positions
  int newSPDPos = encoderSPD.getPosition();
  int newHDGPos = encoderHDG.getPosition();
  int newALTPos = encoderALT.getPosition();
  int newVSPos = encoderVS.getPosition();
  int newTrimPos = encoderTrim.getPosition();

  // Handle SPD encoder if changed
  if (encoderSPDPos != newSPDPos) {
    lastAct = currentTime;

    // SPD control limits
    if (newSPDPos < 100) {
      newSPDPos = 100;
      encoderSPD.setPosition(newSPDPos);
      encoderSPDPos = dontSendSPD;
    }
    if (ktsMachMode) {
      if (newSPDPos > 990) {
        newSPDPos = 990;
        encoderSPD.setPosition(newSPDPos);
        encoderSPDPos = dontSendSPD;
      }
    } else {
      if (newSPDPos > 399) {
        newSPDPos = 399;
        encoderSPD.setPosition(newSPDPos);
        encoderSPDPos = dontSendSPD;
      }
    }

    // Update display
    selectOLED(4);
    display.clearDisplay();
    display.setTextSize(2);
    display.setTextColor(WHITE);
    display.setCursor(0, 0);
    if (ktsMachMode) {
      display.printf("MACH");
      writeDigit(display, 55, 2, 0, WHITE);
      display.fillRoundRect(71, 28, 4, 4, 2, WHITE);  // .
      writeDigits(display, 75, 2, 19, (newSPDPos), WHITE, true);
    } else {
      display.printf("SPD");
      writeDigits(display, 48, 3, 19, (newSPDPos), WHITE, false);
    }
    display.display();

    // Send nasal commands
    if (encoderSPDPos != dontSendSPD) {
      if (encoderSPDPos < newSPDPos) {
        Serial.printf("fcu.FCUController.SPDAdjust(1);\n");
      } else {
        Serial.printf("fcu.FCUController.SPDAdjust(-1);\n");
      }
      click();
    }

    encoderSPDPos = newSPDPos;
  }

  // Handle HDG encoder if changed
  if (encoderHDGPos != newHDGPos) {
    lastAct = currentTime;

    // HDG control limits
    if (newHDGPos < 1) {
      newHDGPos = 360;
      encoderHDG.setPosition(newHDGPos);
      encoderHDGPos = dontSendHDG;
    }
    if (newHDGPos > 360) {
      newHDGPos = 1;
      encoderHDG.setPosition(newHDGPos);
      encoderHDGPos = dontSendHDG;
    }

    // Update HDG display
    selectOLED(3);
    display.clearDisplay();
    display.setTextSize(2);
    display.setTextColor(WHITE);
    display.setCursor(0, 0);
    if (trkFpaMode) {
      display.printf("TRK");
    } else {
      display.printf("HDG");
    }
    writeDigits(display, 48, 3, 19, newHDGPos, WHITE, true);
    display.display();

    // Send nasal commands
    if (encoderHDGPos != dontSendHDG) {
      if (encoderHDGPos < newHDGPos) {
        Serial.printf("fcu.FCUController.HDGAdjust(1);\n");
      } else {
        Serial.printf("fcu.FCUController.HDGAdjust(-1);\n");
      }
      click();
    }

    encoderHDGPos = newHDGPos;
  }

  // Handle ALT encoder if changed
  if (encoderALTPos != newALTPos) {
    lastAct = currentTime;

    // Factor units knob
    if (! unitsMode && encoderALTPos != dontSendALT) {
      newALTPos = newALTPos + ((newALTPos - encoderALTPos) * 9);
      encoderALT.setPosition(newALTPos);
    }

    // ALT control limits
    if (newALTPos < 1) {
      newALTPos = 1;
      encoderALT.setPosition(newALTPos);
      encoderALTPos = dontSendALT;
    }
    if (newALTPos > 490) {
      newALTPos = 490;
      encoderALT.setPosition(newALTPos);
      encoderALTPos = dontSendALT;
    }

    // Update display
    selectOLED(1);
    display.clearDisplay();
    display.setTextSize(2);
    display.setTextColor(WHITE);
    display.setCursor(0, 0);
    display.printf("ALT");
    writeDigits(display, 37, 3, 19, newALTPos, WHITE, true);
    writeDigit(display, 37 + 57, 3, 0, WHITE);
    writeDigit(display, 37 + 76, 3, 0, WHITE);
    display.display();

    // Send nasal commands
    if (encoderALTPos != dontSendALT) {
      if (encoderALTPos < newALTPos) {
        if (unitsMode) {
          Serial.printf("fcu.FCUController.ALTAdjust(1);\n");
        } else {
          Serial.printf("fcu.FCUController.ALTAdjust(10);\n");
        }
      } else {
        if (unitsMode) {
          Serial.printf("fcu.FCUController.ALTAdjust(-1);\n");
        } else {
          Serial.printf("fcu.FCUController.ALTAdjust(-10);\n");
        }
      }
      click();
    }

    encoderALTPos = newALTPos;
  }

  // Handle VS encoder if changed
  if (encoderVSPos != newVSPos) {
    lastAct = currentTime;

    // VS control limits
    if (trkFpaMode) {
      if (newVSPos < -99) {
        newVSPos = -99;
        encoderVS.setPosition(newVSPos);
        encoderVSPos = dontSendVS;
      }
      if (newVSPos > 99) {
        newVSPos = 99;
        encoderVS.setPosition(newVSPos);
        encoderVSPos = dontSendVS;
      }
    } else {
      if (newVSPos < -60) {
        newVSPos = -60;
        encoderVS.setPosition(newVSPos);
        encoderVSPos = dontSendVS;
      }
      if (newVSPos > 60) {
        newVSPos = 60;
        encoderVS.setPosition(newVSPos);
        encoderVSPos = dontSendVS;
      }
    }

    // Update display
    selectOLED(0);
    display.clearDisplay();
    display.setTextSize(2);
    display.setTextColor(WHITE);
    display.setCursor(0, 0);
    if (trkFpaMode) {
      display.printf("FPA");
    } else {
      display.printf("V/S");
    }
    if (vsDashes) {
      // dashes for leveled off display
      writeDigit(display, 56, 3, 10, WHITE);
      writeDigit(display, 75, 3, 10, WHITE);
      writeDigit(display, 94, 3, 10, WHITE);
      writeDigit(display, 113, 3, 10, WHITE);
    } else {
      if (trkFpaMode) {
        if (newVSPos < 0) {
          writeDigit(display, 41, 2, 10, WHITE);  // -
        } else {
          writeDigit(display, 41, 2, 11, WHITE);  // +
        }
        writeDigit(display, 59, 2, abs(newVSPos) / 10, WHITE);
        display.fillRoundRect(74, 28, 4, 4, 2, WHITE);  // .
        writeDigit(display, 78, 2, abs(newVSPos) % 10, WHITE);
      } else {
        if (newVSPos < 0) {
          writeDigit(display, 37, 3, 10, WHITE);  // -
        } else {
          writeDigit(display, 37, 3, 11, WHITE);  // +
        }
        writeDigit(display, 56, 3, abs(newVSPos) / 10, WHITE);
        writeDigit(display, 75, 3, abs(newVSPos) % 10, WHITE);
        writeDigit(display, 94, 3, 12, WHITE);   // o
        writeDigit(display, 113, 3, 12, WHITE);  // o
      }
    }
    display.display();

    // Send nasal commands
    if (encoderVSPos != dontSendVS) {
      if (encoderVSPos < newVSPos) {
        Serial.printf("fcu.FCUController.VSAdjust(1);\n");
      } else {
        Serial.printf("fcu.FCUController.VSAdjust(-1);\n");
      }
      click();
    }

    encoderVSPos = newVSPos;
  }

  // Handle Trim/Zoom encoder if changed
  if (encoderTrimPos != newTrimPos) {
    lastAct = currentTime;

    if (viewMode) {
      // Handle zoom in/out
      if (encoderTrimPos < newTrimPos) {
        Serial.printf("view.decrease(2);\n");
      } else {
        Serial.printf("view.increase(2);\n");
      }
    } else {
      // Handle elevator trim control
      if (encoderTrimPos < newTrimPos) {
        Serial.printf("controls.elevatorTrim(1.75);\n");
      } else {
        Serial.printf("controls.elevatorTrim(-1.75);\n");
      }
      click();
    }

    encoderTrimPos = newTrimPos;
  }
}

// Read incoming data from FlightGear
void handleSerialInput() {
  while (Serial.available()) {
    char c = Serial.read();
    
    // Check for end of record (newline)
    if (c == '\n') {
      // Null-terminate the buffer
      serialBuffer[bufferIndex] = '\0';
      parseData(serialBuffer);
      bufferIndex = 0;
    } 
    // Store char if we have space
    else if (bufferIndex < maxBuffer - 1) {
      serialBuffer[bufferIndex++] = c;
    }
  }
}

// Parse bar-separated data fields
void parseData(char* data) {
  // Use strtok to split by the pipe '|' character
  char* token = strtok(data, "|");
  int fieldIndex = 0;

  while (token != NULL) {
    processField(fieldIndex, token); // Handle the specific field
    token = strtok(NULL, "|");       // Get next token
    fieldIndex++;
  }
}

// Act on data fields received from FlightGear
void processField(int field, char* value) {
  // Field details
  //   0: AP1 LED (bool)
  //   1: AP2 LED (bool)
  //   2: A/THR LED (bool)
  //   3: LOC LED (bool)
  //   4: APPR LED (bool)
  //   5: EXPED LED (bool)
  //   6: MASTER WARN (bool)
  //   7: MASTER CAUTION (bool)
  //   8: KTS/MACH mode (bool, 0=knots)
  //   9: HDG/TRK mode (bool, 0=HDG)
  //  10: VERT display (int, 1=VS, 5=FPA, else dashes)
  //  11: ALT (int)
  //  12: HDG (int)
  //  13: SPD KTS (int)
  //  14: SPD MACH (float)
  //  15: VS (string, e.g., "+60")
  //  16: FPA (float)

  // LED indicators
  if (field == 0) digitalWrite(PIN_AP1, atoi(value));
  if (field == 1) digitalWrite(PIN_AP2, atoi(value));
  if (field == 2) digitalWrite(PIN_ATHR, atoi(value));
  if (field == 3) digitalWrite(PIN_LOC, atoi(value));
  if (field == 4) digitalWrite(PIN_APPR, atoi(value));
  if (field == 5) digitalWrite(PIN_EXPED, atoi(value));
  if (field == 6) warnBlink = (bool)atoi(value);
  if (field == 7) digitalWrite(PIN_CAUT, atoi(value));

  // FCU modes
  if (field == 8 && atoi(value) != (int)ktsMachMode) {
    ktsMachMode = (bool)atoi(value);
    encoderSPDPos = dontSendSPD;
  }
  if (field == 9 && atoi(value) != (int)trkFpaMode) {
    trkFpaMode = (bool)atoi(value);
    encoderHDGPos = dontSendHDG;
    encoderVSPos = dontSendVS;
  }
  if (field == 10) {
    if (atoi(value) == 1 || atoi(value) == 5) {
      if (vsDashes) {
        vsDashes = false;
        encoderVSPos = dontSendVS;
      }
    } else {
      if (! vsDashes) {
        vsDashes = true;
        encoderVSPos = dontSendVS;
      }
    }
  }

  // Encoder display updates only after activity has settled
  if (currentTime > lastAct + 333) {  // 3 Hz
    if (field == 11 && atoi(value) / 100 != encoderALTPos) {
      encoderALT.setPosition(atoi(value) / 100);
      encoderALTPos = dontSendALT;
    }
    if (field == 12 && atoi(value) != encoderHDGPos) {
      encoderHDG.setPosition(atoi(value));
      encoderHDGPos = dontSendHDG;
    }
    if (ktsMachMode) {
      if (field == 14 && (int)(atof(value) * 1000) != encoderSPDPos) {
        encoderSPD.setPosition((int)(atof(value) * 1000));
        encoderSPDPos = dontSendSPD;
      }
    } else {
      if (field == 13 && atoi(value) != encoderSPDPos) {
        encoderSPD.setPosition(atoi(value));
        encoderSPDPos = dontSendSPD;
      }
    }
    if (! vsDashes) {
      if (trkFpaMode) {
        if (field == 16 && (int)(atof(value) * 10) != encoderVSPos) {
          encoderVS.setPosition((int)(atof(value) * 10));
          encoderVSPos = dontSendVS;
        }
      } else {
        if (field == 15 && atoi(value) != encoderVSPos) {
          encoderVS.setPosition(atoi(value));
          encoderVSPos = dontSendVS;
        }
      }
    }
  }
}

// Low priority display tasks
void handlePeriodicUpdates() {
  // These housekeeping tasks are throttled to 1 Hz
  if (currentTime - prevTime > 1000) {;
    prevTime = currentTime;

    // Dim or turn off OLEDs
    if (currentTime - lastAct > dispOffMillis) {
      for (uint8_t s = 0; s < 5; s++) {
        selectOLED(s);
        display.ssd1306_command(SSD1306_DISPLAYOFF);
      }
    } else if (currentTime - lastAct > dispDimMillis) {
      for (uint8_t s = 0; s < 5; s++) {
        selectOLED(s);
        display.ssd1306_command(SSD1306_DISPLAYON);
        display.ssd1306_command(SSD1306_SETCONTRAST);
        display.ssd1306_command(1);
      }
    } else {
      for (uint8_t s = 0; s < 5; s++) {
        selectOLED(s);
        display.ssd1306_command(SSD1306_DISPLAYON);
        display.ssd1306_command(SSD1306_SETCONTRAST);
        display.ssd1306_command(255);
      }
    }

    // Updating center display here to prevent bogging down HDG encoder
    selectOLED(2);
    display.clearDisplay();
    display.setTextSize(2);
    display.setTextColor(WHITE);
    if (trkFpaMode) {
      display.setCursor(24, 18);
      display.printf("TRK  FPA");
    } else {
      display.setCursor(24, 0);
      display.printf("HDG  V/S");
    }

    // Debug output examples. Long press LOC to enable.
    if (debugMode) {
      // Output to serial port every 15 secs
      if (currentTime / 1000 % 15 == 0 ) {
        Serial.printf("info: millis=%d loops/sec=%d\n", millis(), loopCount - loopDiff);
      }
      
      // Output on center display
      if (trkFpaMode) {
        display.setCursor(0, 0);
      } else {
        display.setCursor(0, 18);
      }
      display.printf("L/S %d\n", loopCount - loopDiff);
    }

    // Send to display. This function blocks for 13 ms.
    display.display();

    loopDiff = loopCount;
  }
}

// Main loop
void loop() {
  // Used for throttling logic
  loopCount++;
  currentTime = millis();

  // Check for reboot/debug commands
  handleSystemInputs();

  // Do stateful switches and master warning blink
  handleSwitchesAndLEDs();

  // Read analog axis and flaps values
  handleAnalogControls();

  // Process button press events
  handleResistorLadders();

  // Tick rotary encoders
  handleEncoders();

  // Process incoming data from FlightGear
  handleSerialInput();

  // Low priority display tasks
  handlePeriodicUpdates();
}
