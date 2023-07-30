import processing.serial.*;

final int CATEGORY_HUNGER = 128;
final int CATEGORY_SCORE  = 0;
final int CATEGORY_FINISH = 255;

final int CONNECT_ARDUINO_NUM = 1;

Serial[] serial = new Serial[CONNECT_ARDUINO_NUM];

void initSerial() {
  for (int i = 0; i < CONNECT_ARDUINO_NUM; i++) {
    serial[i] = new Serial(this, Serial.list()[i], 9600);
  }
  
  //serial2 = new Serial(this, Serial.list()[1], 9600);
}

void serialEvent(Serial serialData) {
  int num = Integer.parseInt(serialData.readString());
  print(num);
  
   switch(num % 100) {
   case 0:
     //moveBar(num % 100);
     break;
    
   case 1:
     break;
   
   case 2:
     break;
 }
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
