void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:

  /*
  Serial.print(11);
  Serial.print('s');
  delay(700);
  Serial.print(12);
  Serial.print('s');
  delay(700);
  Serial.print(13);
  Serial.print('s');
  delay(700);
  Serial.print(14);
  Serial.print('s');
  delay(700);
  
  Serial.print(21);
  Serial.print('s');
  delay(700);
  Serial.print(22);
  Serial.print('s');
  delay(700);
  Serial.print(23);
  Serial.print('s');
  delay(700);
  Serial.print(24);
  Serial.print('s');
  delay(700);
  
  Serial.print(30);
  Serial.print('s');
  delay(700);
  Serial.print(31);
  Serial.print('s');
  delay(700);
  Serial.print(32);
  Serial.print('s');
  delay(700);
  Serial.print(33);
  Serial.print('s');
  delay(700);
  Serial.print(34);
  Serial.print('s');
  delay(700);
  
  Serial.print(41);
  Serial.print('s');
  delay(700);
  Serial.print(42);
  Serial.print('s');
  delay(700);
  Serial.print(43);
  Serial.print('s');
  delay(700);
  Serial.print(44);
  Serial.print('s');
  delay(700);
  */

  for (int i = 0; i < 10; i++) {
    Serial.print(130);
    Serial.print('s');
  }
  delay(700);
  for (int i = 0; i < 10; i++) {
    Serial.print(140);
    Serial.print('s');
  }
  delay(700);
}
