#include <Wire.h>
#include <ADXL345.h>
#define CTR2 0 //コントローラ2に書き込む時，ここを1に

ADXL345 adxl;
int x, y, z;

void setup() {
  //button
  pinMode(2, OUTPUT);
  pinMode(3, INPUT_PULLUP);

  //加速度センサ
  Serial.begin(9600);
  adxl.powerOn();
}

void loop() {
  //コントローラ1
  #if !CTR2
  //加速度センサの座標を取得
  adxl.readXYZ(&x, &y, &z); 
  //傾きが
  if(atan2(y, z)>0){ // 右
    if(atan2(x, z)>0){ // 上
      Serial.print(041);
      Serial.print(" ");//パーサ
    }else if(atan2(x, z)<=0){ // 下
      Serial.print(042);
      Serial.print(" ");
    }
  }else if(atan2(y, z)<=0){ // 左
    if(atan2(x, z)>0){ // 上
      Serial.print(031);
      Serial.print(" ");
    }else if(atan2(x, z)<=0){ // 下
      Serial.print(032);
      Serial.print(" ");
    }
  }
  #endif

  //コントローラ2
  #if CTR2
  adxl.readXYZ(&x, &y, &z); 
  //傾きが
  if(atan2(y, z)>0){ // 右
      Serial.print(140);
      Serial.print(" ");
  }else if(atan2(y, z)<=0){ // 左
      Serial.print(130);
      Serial.print(" ");
  }
  //ボタン押下時，団子を発射
  if ( digitalRead(3) == LOW ){
    Serial.print(200);
    Serial.print(" ");
  }
  delay(1);
  #endif
}