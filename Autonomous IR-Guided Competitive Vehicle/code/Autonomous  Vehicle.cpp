#include <AFMotor.h>
#include <SoftwareSerial.h>
#define PULSE_DURATION 38000
// Create motor objects
AF_DCMotor motor1(1); // Motor connected to M1 terminal
AF_DCMotor motor2(2); // Motor connected to M2 terminal
AF_DCMotor motor3(3); // Motor connected to M3 terminal
AF_DCMotor motor4(4); // Motor connected to M4 terminal



const int uss_f_trigPin = 41;//trigger Pin of Ultrasonic Sensor forward  
const int uss_r_trigPin = 33;//trigger Pin of Ultrasonic Sensor right
const int uss_l_trigPin = 50;//trigger Pin of Ultrasonic Sensor left 
const int uss_f_echoPin = 40;//echo Pin of Ultrasonic Sensor forward 
const int uss_r_echoPin = 35;//echo Pin of Ultrasonic Sensor right 
const int uss_l_echoPin = 51;//echo Pin of Ultrasonic Sensor left  

//RECIVER pin value
const int ir_rec_f = 24; 
const int ir_rec_r = 26; 
const int ir_rec_l = 22;

// led pin value for each reciver 
const int ledPin_f = 44;
const int ledPin_r = 46;
const int ledPin_l = 42; 

SoftwareSerial BTSerial(19, 18); // bluetooth reciver and trasmiter 
char b_trigger;

// define motor speed 
const int max_speed=255; // max motor speed 255 
const int min_speed=230; // half speed of max speed (255) 


void setup() {
	
	// Initialize the LED pin as an output
	pinMode(ledPin_f, OUTPUT);
	pinMode(ledPin_r, OUTPUT);
	pinMode(ledPin_l, OUTPUT);

	//define reciver pins:
	pinMode(ir_rec_f, INPUT); 
	pinMode(ir_rec_r, INPUT); 
	pinMode(ir_rec_l, INPUT); 
	//define ultrasoinc sensor pins:
	pinMode(uss_f_trigPin, OUTPUT);
	pinMode(uss_f_echoPin, INPUT);
	pinMode(uss_r_trigPin, OUTPUT);
	pinMode(uss_r_echoPin, INPUT);
	pinMode(uss_l_trigPin, OUTPUT);
	pinMode(uss_l_echoPin, INPUT);
	// Set initial speed to 0
	motor1.setSpeed(0);
	motor2.setSpeed(0);
	motor3.setSpeed(0);
	motor4.setSpeed(0);

	//Initialize LED pin
	//pinMode(ledPin, OUTPUT);
	//digitalWrite(ledPin, LOW);

	// Initialize serial communication
	Serial.begin(9600); //for compialation error 
	Serial1.begin(9600);
	BTSerial.begin(9600);
  
}

void loop() {
	// read reciver value (HIGH or LOW)
  // if(flag==1)
  // {
  //   flag=0;
  // }
  // else
  // {
  //   flag=1;
  // }



	int rec_f=ir_rec(ir_rec_f); //digitalread() this function Reads the value from a specified digital pin, either HIGH or LOW.
	int rec_r=ir_rec(ir_rec_r);
	int rec_l=ir_rec(ir_rec_l);
	// define ultrasonic sensor variables by usuing funcition we created 
	int uss_f=us_sensor_forward();
	int uss_r=us_sensor_right();
	int uss_l=us_sensor_left();
	// Check for Bluetooth b_triggers
  if (Serial1.available()) {
   b_trigger = Serial1.read();//b_trigger is bluetooth trigger
  //Serial.println(b_trigger);
  }
	// Debugging
    //Serial.println(b_trigger);

    //Serial.print("Received: ");
  //  Serial.println(uss_r);
   //Serial.println(uss_f);
	// Control LED based on received b_trigger
	
while (b_trigger=='1')  
{
	digitalWrite(ledPin_f, LOW);  // Turn LED off
	digitalWrite(ledPin_r, LOW);  // Turn LED off
	digitalWrite(ledPin_l, LOW);  // Turn LED off
	uss_f=us_sensor_forward();
  uss_r=us_sensor_right();
  uss_l=us_sensor_left();
	rec_f=ir_rec(ir_rec_f); 
	rec_r=ir_rec(ir_rec_r);
	rec_l=ir_rec(ir_rec_l);

	
	if(uss_f <= 40)//40 cm 
	{
		if(uss_r<uss_l)
		{
			turnRight(max_speed);
			delay(450);
			moveForward(max_speed);
			delay(800);
			turnLeft(max_speed);
			delay(450);
      moveForward(max_speed);
			delay(800);
			turnLeft(max_speed);
      delay(450);
      moveForward(max_speed);
			delay(400);
      turnRight(max_speed);
			delay(450);
			stopMotors();
		}
		else
		{
			turnLeft(max_speed);
			delay(450);
			moveForward(max_speed);
			delay(800);
			turnRight(max_speed);
			delay(450);
      moveForward(max_speed);
			delay(800);
			turnRight(max_speed);
      delay(450);
      moveForward(max_speed);
			delay(400);
      turnLeft(max_speed);
			delay(450);
      stopMotors();
		}
		
	}
	else if (uss_r<=30)//20 cm
	{
		turnRight(min_speed);
		delay(250);
		moveForward(max_speed);
		delay(200);
		stopMotors();
	}
		
	else if (uss_l<=30) 
	{
		turnLeft(min_speed);
		delay(250);
		moveForward(max_speed);
		delay(200);
		stopMotors();
	}
	
	else if (uss_f>35 and uss_r>30 and uss_l>30)
	{
		
	  if(rec_f == LOW )
	  {
		  digitalWrite(ledPin_f, HIGH);  // Turn LED on
		  moveForward(max_speed);
		  delay(300);
	  }
	  else if(rec_r==LOW)
	  {
		  digitalWrite(ledPin_r, HIGH);  // Turn LED on
		  turnRight(180);
		  delay(400);// 0.5 sec
		  moveForward(max_speed);
      delay(300);
		  stopMotors();
		  delay(200);// 0.5 sec 
	  }
	  else if(rec_l==LOW)
	  {
		  digitalWrite(ledPin_l, HIGH);  // Turn LED on
		  turnLeft(180);
		  delay(300);// 0.5 sec
		  moveForward(max_speed);
		  delay(400);
		  stopMotors();
		  delay(200);// 0.5 sec
	  }
    else 
	  {
      moveForward(255);
	  }
	}
  else 
	{
    moveForward(255);
	}
  if (Serial1.available()) {
   b_trigger = Serial1.read();//b_trigger is bluetooth trigger
  //Serial.println(b_trigger);
  }
}
if (b_trigger=='0') 
	{
	  stopMotors();
    }

}

//declare function of ultrasoinc sensor: 
int us_sensor_forward()
{
	digitalWrite(uss_f_trigPin, LOW);
	delayMicroseconds(2);
	digitalWrite(uss_f_trigPin, HIGH);
	delayMicroseconds(10);
	digitalWrite(uss_f_trigPin, LOW);
	unsigned int time_duration = pulseIn(uss_f_echoPin, HIGH);
	unsigned int distance = (time_duration*0.034)/2; 
	// The value is multiplied by 1/2 because T is the time for go-and-return distance 
	// speed of sound is (340 m/s)>>velocity[m/s]*time[microsec]>> 343*100 [cm/s]*[1micro]= 0.0343 [cm/s]    
	//Serial.print("Distance: ");
  if(distance==0)
  {
    digitalWrite(uss_f_trigPin, LOW);
	  delayMicroseconds(2);
	  digitalWrite(uss_f_trigPin, HIGH);
	  delayMicroseconds(10);
	  digitalWrite(uss_f_trigPin, LOW);
	  time_duration = pulseIn(uss_f_echoPin, HIGH);
	  distance = (time_duration*0.034)/2; 
  }
 // Serial.println(distance);
	return distance; // return the value from the ultrasonic sensor
	//not finished yet 
}
int us_sensor_right()
{
	digitalWrite(uss_r_trigPin, LOW);
	delayMicroseconds(2);
	digitalWrite(uss_r_trigPin, HIGH);
	delayMicroseconds(10);
	digitalWrite(uss_r_trigPin, LOW);
	unsigned int time_duration = pulseIn(uss_r_echoPin, HIGH);
	unsigned int distance = (time_duration*0.034)/2; 
  if(distance==0)
  {
	digitalWrite(uss_r_trigPin, LOW);
	delayMicroseconds(2);
	digitalWrite(uss_r_trigPin, HIGH);
	delayMicroseconds(10);
	digitalWrite(uss_r_trigPin, LOW);
	time_duration = pulseIn(uss_r_echoPin, HIGH);
	distance = (time_duration*0.034)/2; 
  }
	// The value is multiplied by 1/2 because T is the time for go-and-return distance 
	// speed of sound is (340 m/s)>>velocity[m/s]*time[microsec]>> 343*100 [cm/s]*[1micro]= 0.0343 [cm/s]    
	//Serial.print("Distance: ");
	//Serial.println(distance);
	return distance; // return the value from the ultrasonic sensor
	//not finished yet
}
int us_sensor_left()
{
	digitalWrite(uss_l_trigPin, LOW);
	delayMicroseconds(2);
	digitalWrite(uss_l_trigPin, HIGH);
	delayMicroseconds(10);
	digitalWrite(uss_l_trigPin, LOW);
  
	unsigned int time_duration = pulseIn(uss_l_echoPin, HIGH); // pulseIn Reads a pulse (either HIGH or LOW) on a pin
	unsigned int distance = (time_duration*0.034)/2; 
    if(distance==0)
  {
	digitalWrite(uss_l_trigPin, LOW);
	delayMicroseconds(2);
	digitalWrite(uss_l_trigPin, HIGH);
	delayMicroseconds(10);
	digitalWrite(uss_l_trigPin, LOW);
	time_duration = pulseIn(uss_l_echoPin, HIGH);
	distance = (time_duration*0.034)/2; 
  }
	// The value is multiplied by 1/2 because T is the time for go-and-return distance 
	// speed of sound is (340 m/s)>>velocity[m/s]*time[microsec]>> 343*100 [cm/s]*[1micro]= 0.0343 [cm/s]    
	//Serial.print("Distance: ");
	//Serial.println(distance);
	return distance; // return the value from the ultrasonic sensor
	//not finished yet 
}

// declare function of motor driver
void moveForward(int speed) {
  motor1.setSpeed(speed);
  motor2.setSpeed(speed);
  motor3.setSpeed(speed);
  motor4.setSpeed(speed);
  motor1.run(FORWARD);
  motor2.run(FORWARD);
  motor3.run(FORWARD);
  motor4.run(FORWARD);
}

void moveBackward(int speed) {
  motor1.setSpeed(speed);
  motor2.setSpeed(speed);
  motor3.setSpeed(speed);
  motor4.setSpeed(speed);
  motor1.run(BACKWARD);
  motor2.run(BACKWARD);
  motor3.run(BACKWARD);
  motor4.run(BACKWARD);
}

void turnRight(int speed) {
  motor1.setSpeed(speed);
  motor2.setSpeed(speed);
  motor3.setSpeed(speed);
  motor4.setSpeed(speed);
  motor1.run(FORWARD);
  motor2.run(FORWARD);
  motor3.run(BACKWARD);
  motor4.run(BACKWARD);
}

void turnLeft(int speed) {
  motor1.setSpeed(speed);
  motor2.setSpeed(speed);
  motor3.setSpeed(speed);
  motor4.setSpeed(speed);
  motor1.run(BACKWARD);
  motor2.run(BACKWARD);
  motor3.run(FORWARD);
  motor4.run(FORWARD);
}

void stopMotors() {
  motor1.run(RELEASE);
  motor2.run(RELEASE);
  motor3.run(RELEASE);
  motor4.run(RELEASE);
}


int ir_rec(int rec_d)
{
	int t1=pulseIn(rec_d,HIGH,PULSE_DURATION);
	//Serial.println(t1);
	int t2=pulseIn(rec_d,LOW,PULSE_DURATION);
	//Serial.println(t2);
	int f=1000000/(t1+t2);
	//Serial.println(f);
	if (f >= 160 && f <= 200) 
	{
		return 0;
	}
	else
	{
		return 1;
	}
}

