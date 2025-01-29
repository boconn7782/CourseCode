/*
  Blink - Button
  
  1 LED should switch on and off every second. 
  The other LED should be on when the button is pushed. 
  
*/

// constants that won't change:
// set pin numbers:
const int buttonPin = 2;  // the number of the pushbutton pin
const int LED1Pin =  13;  // the number of the LED pin
const int LED2Pin =  12;  // the number of the LED pin

// variables that will change:
int buttonState = 0;      // variable for reading the pushbutton status
int lastButtonState = 0;  // Variable for tacking the last button state
int LED2State = 0; 

void setup() {                  
  // initialize the LED pins as digital outputs:
  pinMode(LED1Pin, OUTPUT);
  pinMode(LED2Pin, OUTPUT);   
  // initialize the pushbutton pin as a digital input:
  pinMode(buttonPin, INPUT); 
}

void loop() {             
  // The Blink Example
  // switching on the led 
  digitalWrite(LED1Pin, HIGH);
  // stopping the program for 1000 milliseconds
  delay(1000);
  // switching off the led 
  digitalWrite(LED1Pin, LOW);
  // stopping the program for 1000 milliseconds
  delay(1000);

  // The Button Example
  // read the state of the pushbutton value:
  buttonState = digitalRead(buttonPin);

  // check if the pushbutton is pressed. If it is, the buttonState is HIGH:
  if (buttonState == LOW && lastButtonState != buttonState) {
    // turn LED on:
    LED2State = !LED2State;
  }
  
  // Writing LED pin to desired state
  digitalWrite(LED2Pin, LED2State);
  
  lastButtonState = buttonState; // Tracking last button state
}
