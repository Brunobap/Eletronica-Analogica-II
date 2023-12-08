
#define BLYNK_PRINT Serial
#define BLYNK_TEMPLATE_ID "TMPL2Hi9qRYX2"
#define BLYNK_TEMPLATE_NAME "proj3Micro"

#include <BlynkSimpleEsp8266.h>

// Enter your Auth token
char auth[] = "n5nGsG_ofYKfimVKIVg7DwSpma-Sb7br";

//Enter your WIFI SSID and password
char ssid[] = "Samsung SmartFridge";
char pass[] = "eggk6272";

void setup(){
  // Debug console
  Serial.begin(9600);
  Blynk.begin(auth, ssid, pass, "blynk.cloud", 80);
}

void loop(){
  Blynk.run();
}