/*
Starter code for P3H1
The Arduino example Button but with the assignment psuedocode folded in to scaffold our activity
WARNING: There are logical flaws in the pseudocode that we will discuss and fix in class
*/

// PROGRAM P3H2:​

// constants won't change. They're used here to set pin numbers:
const int buttonPin = 2;  // the number of the pushbutton pin
const int ledPin = 13;    // the number of the LED pin

// variables will change:
int buttonState = 0;  // variable for reading the pushbutton status

// Warning: You'll need more of each of the variables based on the psuedocode

void setup() {
  // initialize the LED pin as an output:
  pinMode(ledPin, OUTPUT);
  // initialize the pushbutton pin as an input:
  pinMode(buttonPin, INPUT);

  // From pseudocode
  // Setup RedBtn pin as INPUT, ​for component Red Button;​
  // Setup GrnBtn pin as INPUT, ​for component Green Button;​
  // Setup BluBtn pin as INPUT, ​for component Blue Button;​

  // Setup RedLED pin as INPUT, ​for component RGB LED - Red;​
  // Setup GrnLED pin as INPUT, ​for component RGB LED - Green;​
  // Setup BluLED pin as INPUT, ​for component RGB LED - Blue;
}

// WHILE 1
void loop() {
  // SENSE
  // read the state of the pushbutton value:
  buttonState = digitalRead(buttonPin);

  // From pseudocode: 
  // READ Red Button state INTO RedBtnState;​
  // READ Green Button state INTO GrnBtnState;​
  // READ Blue Button state INTO BluBtnState;​

  // THINK - ACT
  
  // check if the pushbutton is pressed. If it is, the buttonState is HIGH:
  if (buttonState == HIGH) {
    // turn LED on:
    digitalWrite(ledPin, HIGH);
  } else {
    // turn LED off:
    digitalWrite(ledPin, LOW);
  }

  // From pseudocode: 
  // IF RedBtnState IS HIGH​
  // Turn RGB’s Red LED On​
  // ELSEIF GrnBtnState IS HIGH​
  // Turn RGB’s Green LED On​
  // ELSEIF BluBtnState IS HIGH​
  // Turn RGB’s Blue LED On​
  // ELSE​IF <Combinations cause flickering>​
  // You'll need to determine LOGICAL AND to handle combinations (Hint: www.arduino.cc/reference/en/​)
  // ENDIF​

} // ENDWHILE
//END
