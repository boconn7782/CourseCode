/************************************************************************************
   SIK Bot Example Code
   2024-07-06
   - Prof. O'Connell

   A basic program that runs through the standard maneuvering functions for the SIK Bot.

   Includes the following functions that can be copied and used in your own programs: 
     FWD(int speed) - Moves Forward at inputted speed
     BWD(int speed) - Moves Backward at inputted speed
     RT(int speed) - Turns Right at inputted speed
     LT(int speed) - Turns Left at inputted speed
     STOP() - Stops by cutting power to the motors

******************************************************************************************/
// Control pins for the RIGHT motor
const int AIN1 = 13;  // AI1 - control pin 1 on the motor driver for the right motor
const int AIN2 = 12;  // AI2 - control pin 2 on the motor driver for the right motor
const int PWMA = 11;  // PWMA - speed control pin on the motor driver for the right motor

// Control pins for the LEFT motor
const int PWMB = 10;  // speed control pin on the motor driver for the left motor
const int BIN2 = 9;   //control pin 2 on the motor driver for the left motor
const int BIN1 = 8;   //control pin 1 on the motor driver for the left motor

// Setting a default delay to use for demonstration purposes
int D = 5000;

// Setting a default speed to use for demonstration purposes
int S = 200; 

void setup()
{
  //set the motor control pins as outputs
  pinMode(AIN1, OUTPUT);
  pinMode(AIN2, OUTPUT);
  pinMode(PWMA, OUTPUT);

  pinMode(BIN1, OUTPUT);
  pinMode(BIN2, OUTPUT);
  pinMode(PWMB, OUTPUT);

  // Starting Serial Monitor for debugging
  Serial.begin(9600); //begin serial communication with the computer

}

/****************************************/
void loop()
{
  // Demonstrating moving in all directions at varying speeds
  FWD(S);   // Moves forward at speed S
  delay(D); // Delays for S microseconds
  RT(S);    // Turns forward at speed S
  delay(D); // Delays for S microseconds
  FWD(S);   // Moves forward at speed S
  delay(D); // Delays for S microseconds
  // STOP();   // Stops the motors
  delay(D); // Delays for S microseconds
  BWD(S);  // Moves backward at speed S
  delay(D); // Delays for S microseconds
  LT(S);    // Turns Left at speed S
  delay(D); // Delays for S microseconds
  BWD(S);  // Moves backward at speed S
  delay(D); // Delays for S microseconds
  STOP();   // Stops the motors
  delay(D); // Delays for S microseconds

  // Update the speed. This will increment the speed after each iteration, then reset to the low speed when it hits
  // if(S>=250) {
  //   S=125; // Reset to a slow speed
  // }
  // else 
  // {
  //   S=S+25; // Increase the speed
  // }

// Here's a tip for debugging your code 
// Serial Code
// if some weird case that I think should be happening, add a serial print. 
// Notice that each function prints out what it's doing so you can get feedback
// from the serial monitor about what the program thinks it should be doing
//    Serial.println("Is the code getting to this point?");
// 
// If you have it not plugged in, you can also add an LED and have that LED also light up
// when you want it to do something. For instance, if it's supposed to turn right and doesn't, 
// add an LED blink in the code when that happens. If the LED lights up, it's a motor issue; 
// if it doesn't, then it's a sensor or code issue. 


}


/*************************************/
/* Do not change the functions below */
/*************************************/

/* Moves the Robot forward */
void FWD(int speed)
{
  //Print status
  Serial.println("Moving Forward.");
  // Set RIGHT motor Forward
  digitalWrite(AIN1, HIGH);
  digitalWrite(AIN2, LOW);
  // Set LEFT motor Forward
  digitalWrite(BIN1, HIGH);
  digitalWrite(BIN2, LOW);
  // Set Motor Speeds
  analogWrite(PWMA, speed);
  analogWrite(PWMB, speed);
}

/* Moves the Robot in Reverse */
void BWD(int speed)
{
  //Print status
  Serial.println("Moving Backward.");
  // Set RIGHT motor Backward
  digitalWrite(AIN1, LOW);
  digitalWrite(AIN2, HIGH);
  // Set LEFT motor Backward
  digitalWrite(BIN1, LOW);
  digitalWrite(BIN2, HIGH);
  // Set Motor Speeds
  analogWrite(PWMA, speed);
  analogWrite(PWMB, speed);
}

/* Turns the Robot to the Right */
void RT(int speed)
{
  //Print status
  Serial.println("Right Turn.");
  // Set RIGHT motor Backward
  digitalWrite(AIN1, LOW);
  digitalWrite(AIN2, HIGH);
  // Set LEFT motor Forward
  digitalWrite(BIN1, HIGH);
  digitalWrite(BIN2, LOW);
  // Set Motor Speeds
  analogWrite(PWMA, speed);
  analogWrite(PWMB, speed);
}

/* Turns the Robot to the left */
void LT(int speed) 
{
  //Print status
  Serial.println("Left Turn.");
  // Set RIGHT motor Forward
  digitalWrite(AIN1, HIGH);
  digitalWrite(AIN2, LOW);
  // Set LEFT motor Backward
  digitalWrite(BIN1, LOW);
  digitalWrite(BIN2, HIGH);
  // Set Motor Speeds
  analogWrite(PWMA, speed);
  analogWrite(PWMB, speed);
}

/* Stops the Motors */
void STOP()
{
  //Print status
  Serial.println("Stopping.");
  // Turn RIGHT motor Off
  digitalWrite(AIN1, LOW);
  digitalWrite(AIN2, LOW);
  // Set LEFT motor Forward
  digitalWrite(BIN1, LOW);
  digitalWrite(BIN2, LOW);
  // Set Motor Speeds to 0
  analogWrite(PWMA, 0);
  analogWrite(PWMB, 0);
}
