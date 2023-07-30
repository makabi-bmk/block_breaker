import processing.serial.*;

final int CATEGORY_HUNGER = 128;
final int CATEGORY_SCORE  = 0;
final int CATEGORY_FINISH = 255;

final int CONNECT_ARDUINO_NUM = 1;

Serial[] serial = new Serial[CONNECT_ARDUINO_NUM];
int command = 0;

void initSerial() {
  for (int i = 0; i < CONNECT_ARDUINO_NUM; i++) {
    serial[i] = new Serial(this, Serial.list()[i], 9600);
  }
}

void serialEvent(Serial serialData) {
  char data = serialData.readChar();
  if(data != 's') {
    int num = Character.getNumericValue(data);
    command = command * 10 + num;
    return;
  }
  
  println(command);
  switch(command / 100) {
   case 0:
     setBarArea(command / 10);
     setBar(command % 10);
     break;
    
   case 1:
     boolean direction = (command / 10 == 13) ? true : false;
     dango.move(direction);
     break;
   
   case 2:
     addBall(bar.getX(), bar.getY());
     break;
 }
 command = 0;
}

/*
void lightUpHungerData(int status) {
  submitDataToArduino(CATEGORY_HUNGER, status);
}

void lightUpScoreData(int status) {
  submitDataToArduino(CATEGORY_SCORE, status);
}

void finishLightUp() {
  submitDataToArduino(CATEGORY_FINISH);
}

void submitDataToArduino(int category, int data) {
  int sendData = category + data;
  println(sendData);
  //serial1.write(sendData);
}

void submitDataToArduino(int data) {
  println(data);
  //serial1.write(data);
}
*/
