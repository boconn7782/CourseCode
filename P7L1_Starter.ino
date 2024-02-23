/*
  P7L1
	<first Initial>.<Last Name>
  <Date of creation>
  Sound to Light
	Serves as an Arduino listening Example, where the Arduino listens 
  for messages over serial communication, looks for a specific character, 
  then takes the information after that character as the intended data. 
  It uses that data to write the level to the LED. 
*/

const int ledPin = 11; 
int dataIn; // For holding the usable data from the message
char SerData; // Need to make sure there's enough space for our message



void setup() {
  // Initialize serial communication

  // Adjust Serial Time Out

  // By default, some serial commands will take up to a second to run if waiting for data. 
  // We're speeding up the response time so our Arduino isn't delayed by this.
}


void loop() {
  // IF Serial Available THEN
  if ( ) {
    // Read a character from the buffer
    SerCode =   ; 
    // We're using that single character as an indicator of a formatted message
    
    // IF that character is 'a'
    if ( ) {
      // Read buffer for an integer
      dataIn =   ;   // Reads until there is no longer numerical characters
      // Write that value to the LED pin
      analogWrite(ledPin, dataIn);  // Write value to
    } //ENDIF
  } // ENDIF
}
