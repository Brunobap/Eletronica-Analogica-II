
#define BLYNK_PRINT Serial
#define BLYNK_TEMPLATE_ID "TMPL2Hi9qRYX2"
#define BLYNK_TEMPLATE_NAME "proj3Micro"

#include <BlynkSimpleEsp8266.h>

// Enter your Auth token
char auth[] = "yYzOruB4DoQm67JtmLc5Kz7dUAS6IbNg";

//Enter your WIFI SSID and password
char ssid[] = "Samsung SmartFridge";
char pass[] = "eggk6272";

#define LED_PIN 5

int status = 0;
int onOff = 0;

// V0 is a datastream used to transfer and store LED switch state.
// Evey time you use the LED switch in the app, this function
// will listen and update the state on device
BLYNK_WRITE(V0)
{
  status = param.asInt();
}
BLYNK_WRITE(V1)
{
  onOff = param.asInt();
}

void setup()
{
  pinMode(LED_PIN, OUTPUT);

  // Debug console. Make sure you have the same baud rate selected in your serial monitor
  Serial.begin(115200);
  delay(100);

  Blynk.begin(auth, ssid, pass, "blynk.cloud", 80);
}

void loop() {
  Blynk.run();
  if (onOff == 1) { PWM(); }
}

void PWM() {
  digitalWrite(LED_PIN, HIGH);
  delay(status/10);
  digitalWrite(LED_PIN, LOW);
  delay(10-(status/10));
}