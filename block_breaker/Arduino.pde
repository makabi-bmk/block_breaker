import processing.serial.*;

final int CATEGORY_HUNGER = 128;
final int CATEGORY_SCORE  = 0;
final int CATEGORY_FINISH = 255;

Serial serial;

void initSerial() {
  serial = new Serial(this, Serial.list()[0], 9600);
}

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
  serial.write(sendData);
}

void submitDataToArduino(int data) {
  println(data);
  serial.write(data);
}
