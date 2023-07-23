#include <Adafruit_NeoPixel.h>
Adafruit_NeoPixel pixels = Adafruit_NeoPixel(2, 2, NEO_RGB + NEO_KHZ800);

const int CATEGORY_HUNGER = 128;
const int CATEGORY_SCORE  = 0;
const int BLOCK_COLORS[4][3] = {{0, 153, 20}, {192, 192, 192}, {255, 215, 0}, {139, 0, 0}};

const int TIME_BONUS_COLORS[4][3] = {{243, 152, 0}, {255, 241, 0}, {143, 195, 31}, {0, 0, 0}};
const int TIME_BONUS_NONE = 3;

void setup() {
  // put your setup code here, to run once:
  pixels.begin();
  Serial.begin(9600);
//  pinMode(2, OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
 
  digitalWrite(2, LOW);
  while (Serial.available() > 0) {
    int data = Serial.read();
    if (data == 255) {
      pixels.setPixelColor(0, pixels.Color(0, 0, 0));
      pixels.setPixelColor(1, pixels.Color(0, 0, 0));
    } else if (data >= CATEGORY_HUNGER) {
        int* mColor = TIME_BONUS_COLORS[data - CATEGORY_HUNGER];
        Serial.println(data - CATEGORY_HUNGER);
        pixels.setPixelColor(0, pixels.Color(mColor[0], mColor[1], mColor[2]) );
    } else {
      int* mColor = BLOCK_COLORS[data];
      pixels.setPixelColor(1, pixels.Color(mColor[0], mColor[1], mColor[2]));
    }
    
    pixels.show();
  } 
  delay(100);

  
}
