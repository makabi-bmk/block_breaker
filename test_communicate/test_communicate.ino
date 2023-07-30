void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  Serial.print(10);
  Serial.print('s');
  delay(700);
  Serial.print(20);
  Serial.print('s');
  delay(700);
  Serial.print(30);
  Serial.print('s');
  delay(700);
  Serial.print(40);
  Serial.print('s');
  delay(700);
}
