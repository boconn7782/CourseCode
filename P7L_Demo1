/*
  Serial Communication Example
  B.O'Connell 2024-02-11

  This is meant to showcase how the Arduino reads a serial message 1 character at a time.
*/

char IncomingByte;

void setup() {
  Serial.begin(9600);
}

void loop() {

  // This causes the arduino to wait until a new serial communication message is sent
  while (!Serial.available()){
    // Essentially says While Serial Coms NOT available, do nothing
  };  

  if (Serial.available()) {  // If anything comes in Serial (USB),
    // Read the next byte in the serial buffer
    IncomingByte = Serial.read();  

    // say what you got:
    Serial.print("Arduino read this character: ");
    Serial.println(IncomingByte);  // Prints out just that single character
    
    // If there is no more data in the buffer
    if (Serial.available() == 0) {
      Serial.println("No more data in the buffer");
    }
  }
}
