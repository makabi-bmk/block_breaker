#include <Wire.h>
#include <ADXL345.h>
#define CTR2 1 //コントローラ2に書き込む時，ここを1に

ADXL345 adxl;
int x, y, z;
int  pastx, pasty;
int vx, vy;

bool buttonFlag = false;

void setup() {
  //button
  pinMode(2, OUTPUT);
  pinMode(3, INPUT_PULLUP);

  //加速度センサ
  Serial.begin(9600);
  adxl.powerOn();
  adxl.readXYZ(&pastx, &pasty, &z); 
}

void loop() {
  //コントローラ1
  #if !CTR2
  //加速度センサの座標を取得
  adxl.readXYZ(&x, &y, &z); 
  //傾きが

  vx = abs(x - pastx);
  vy = abs(y - pasty);

  if(vy > vx){ //左右

    if(atan2(y, z) >0){ // 右
      if(atan2(x, z)>0){ // 上
        Serial.print(41);
        Serial.print('s');//パーサ
      }else if(atan2(x, z)<=0){ // 下
        Serial.print(42);
        Serial.print('s');
      }
    }
    else { // 左
      if(atan2(x, z)>0){ // 上
        Serial.print(31);
        Serial.print('s');
      }else if(atan2(x, z)<=0){ // 下
        Serial.print(32);
        Serial.print('s');
      }
    }
  }else{
    if(atan2(x, z) >0){ // 上
      if(atan2(y, z)>0){ // 右
        Serial.print(14);
        Serial.print('s');//パーサ
      }else if(atan2(y, z)<=0){ // 左
        Serial.print(13);
        Serial.print('s');
      }
    }else { // 下
      if(atan2(y, z)>0){ // 右
        Serial.print(24);
        Serial.print('s');
      }else if(atan2(y, z)<=0){ // 左
        Serial.print(23);
        Serial.print('s');
      }
    }
  }

  x=pastx;
  y=pasty;  
  #endif

  //コントローラ2
  #if CTR2
  adxl.readXYZ(&x, &y, &z); 
  //傾きが
  if(atan2(y, z)>0){ // 右
      Serial.print(140);
      Serial.print('s');
  }else if(atan2(y, z)<=0){ // 左
      Serial.print(130);
      Serial.print('s');
  }
  //ボタン押下時，団子を発射
  if ( digitalRead(3) == LOW ){
    if (buttonFlag == false) {
      Serial.print(200);
      Serial.print('s');
      buttonFlag = true;
    }
  } else {
    buttonFlag = false;
  }
  delay(1);
  #endif
}
