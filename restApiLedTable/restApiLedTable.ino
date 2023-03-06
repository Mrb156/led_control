#include <stdio.h>
#include <ESP8266WebServer.h>
#include <ArduinoJson.h>
#include <FastLED.h>

#define NUM_LEDS 162
#define LED_PIN 4
CRGB leds[NUM_LEDS];

#define HTTP_REST_PORT 80
#define WIFI_RETRY_DELAY 500
#define MAX_WIFI_INIT_RETRY 50

// Set Static IP address
IPAddress local_IP(192, 168, 0, 73);
// Set Gateway IP address
IPAddress gateway(192, 168, 0, 1);
IPAddress subnet(255, 255, 255, 0);

struct Led {
  uint8_t redValue;
  uint8_t greenValue;
  uint8_t blueValue;
  uint8_t br;
  uint8_t prog;//0 az a sima szín --> üres program
  uint8_t hue = 0;
  uint8_t paletteIndex = 0;
}led_source;

//palette beállítása
DEFINE_GRADIENT_PALETTE (g1) {
  0,  153, 0, 120,  //hely, R, G, B
  128,  153, 0, 3,
  255,  0, 141, 153,
};
CRGBPalette16 myPal = g1;

DEFINE_GRADIENT_PALETTE( g2 ) {
  0,    0,  0,    0,     //green
  85,    255,  0,  0,     //bluegreen
  170,  255,  255,  0,     //gray
  255,  255,   255,    255,     //brown
};
CRGBPalette16 g_w_p = g2;
  


const char* wifi_ssid = "Vodafone-4DBE";
const char* wifi_passwd = "Cc5fvxrdsuEr";

ESP8266WebServer http_rest_server(HTTP_REST_PORT);

void init_led_source() {
  led_source.redValue = 0;
  led_source.greenValue = 0;
  led_source.blueValue = 0;
  led_source.br = 0;
  led_source.prog = 0;
}

int init_wifi() {
  int retries = 0;

  Serial.println("Connecting to WiFi AP..........");

  //WiFi.mode(WIFI_STA);
  if (!WiFi.config(local_IP, gateway, subnet)) {
    Serial.println("STA Failed to configure");
  }
  WiFi.begin(wifi_ssid, wifi_passwd);
  // check the status of WiFi connection to be WL_CONNECTED
  while ((WiFi.status() != WL_CONNECTED) && (retries < MAX_WIFI_INIT_RETRY)) {
    retries++;
    delay(WIFI_RETRY_DELAY);
    Serial.print("#");
  }
  return WiFi.status();  // return the WiFi connection status
}

void get_leds() {
  StaticJsonBuffer<200> jsonBuffer;
  JsonObject& jsonObj = jsonBuffer.createObject();
  char JSONmessageBuffer[200];


  jsonObj["redValue"] = led_source.redValue;
  jsonObj["greenValue"] = led_source.greenValue;
  jsonObj["blueValue"] = led_source.blueValue;
  jsonObj["prog"] = led_source.prog;

  jsonObj.prettyPrintTo(JSONmessageBuffer, sizeof(JSONmessageBuffer));
  http_rest_server.send(200, "application/json", JSONmessageBuffer);
}

void json_to_resource(JsonObject& jsonBody) {
    uint8_t redValue, greenValue, blueValue, bright, prog;

    redValue = jsonBody["redValue"];
    greenValue = jsonBody["greenValue"];
    blueValue = jsonBody["blueValue"];
    bright = jsonBody["brightness"];
    prog = jsonBody["prog"];

    led_source.redValue = redValue;
    led_source.greenValue = greenValue;
    led_source.blueValue = blueValue;
    led_source.br = bright;
    led_source.prog = prog;
}
////////////////////
//led programok
void ledShow() {
  FastLED.setBrightness(led_source.br);
  for (int i = 0; i < NUM_LEDS; i++) {
    leds[i] = CRGB(led_source.redValue, led_source.greenValue, led_source.blueValue);
    //leds[i] = CRGB(200, 0, 0);
  }
  FastLED.show();
}

void snake()
{
  FastLED.setBrightness(led_source.br);
  uint16_t sinBeat = beatsin16(10, 0, NUM_LEDS, 0, 0);
  leds[sinBeat] = CRGB(led_source.redValue, led_source.greenValue, led_source.blueValue);
  fadeToBlackBy(leds, NUM_LEDS, 20);
  FastLED.show();
}
void rainbow()
{

  FastLED.setBrightness(led_source.br);
  for (int i = 0; i < NUM_LEDS; i++)
  {
    // hue, saturation, value
    leds[i] = CHSV(led_source.hue, 255, 255);
    EVERY_N_MILLISECONDS(15)
    {
      led_source.hue++;
    }
  }
  FastLED.show();
}
void u_rainbow()
{
  FastLED.setBrightness(led_source.br);
  for (int i = 0; i < NUM_LEDS; i++)
  {
    leds[i] = CHSV(led_source.hue + (i * 10), 255, 255);
  }
  EVERY_N_MILLISECONDS(10)
  {
    led_source.hue++;
  }
  FastLED.show();

}
void pat()
{
  fill_palette(leds, NUM_LEDS, led_source.paletteIndex, 1, myPal, 255, LINEARBLEND);
  FastLED.setBrightness(led_source.br);
  FastLED.show();
}
void g_wave()
{
  int16_t beatA = beatsin16(30, 0, 255);
  uint16_t beatB = beatsin16(20, 0, 255);
  fill_palette(leds, NUM_LEDS, (beatA + beatB) / 2, 10, myPal, 255, LINEARBLEND);
  FastLED.setBrightness(led_source.br);
  FastLED.show();
}
////////////////////////

void post_put_leds() {
  StaticJsonBuffer<500> jsonBuffer;
  String post_body = http_rest_server.arg("plain");
  Serial.println(post_body);

  JsonObject& jsonBody = jsonBuffer.parseObject(http_rest_server.arg("plain"));

  Serial.print("HTTP Method: ");
  Serial.println(http_rest_server.method());

  if (!jsonBody.success()) {
    Serial.println("error in parsin json body");
    http_rest_server.send(400);
  } else {
    if (http_rest_server.method() == HTTP_POST) {
      http_rest_server.sendHeader("Location", "/leds/");
      http_rest_server.send(201);
      json_to_resource(jsonBody);
      // ledShow();

    } else if (http_rest_server.method() == HTTP_PUT) {
      http_rest_server.sendHeader("Location", "/leds/");
      http_rest_server.send(200);
      json_to_resource(jsonBody);
      // ledShow();

    } else
      http_rest_server.send(404);
  }
}

void config_rest_server_routing() {
  http_rest_server.on("/", HTTP_GET, []() {
    http_rest_server.send(200, "text/html",
                          "Welcome to the ESP8266 REST Web Server");
  });
  http_rest_server.on("/leds", HTTP_GET, get_leds);
  http_rest_server.on("/leds", HTTP_POST, post_put_leds);
  http_rest_server.on("/leds", HTTP_PUT, post_put_leds);
}


void setup(void) {
  FastLED.addLeds<WS2812B, LED_PIN, GRB>(leds, NUM_LEDS);
  FastLED.setBrightness(50);

  Serial.begin(115200);

  init_led_source();
  if (init_wifi() == WL_CONNECTED) {
    Serial.print("Connetted to ");
    Serial.print(wifi_ssid);
    Serial.print("--- IP: ");
    Serial.println(WiFi.localIP());
  } else {
    Serial.print("Error connecting to: ");
    Serial.println(wifi_ssid);
  }

  config_rest_server_routing();

  http_rest_server.begin();
  Serial.println("HTTP REST Server Started");
}

void loop(void) {
  if(led_source.prog == 0){
    ledShow();
  }
  else if(led_source.prog == 1){
    snake();
  }
  else if(led_source.prog == 2){
    rainbow();
  }
  else if(led_source.prog == 3){
    u_rainbow();
  }
  else if(led_source.prog == 4){
    pat();
  }
  else if(led_source.prog == 5){
    g_wave();
  }
  http_rest_server.handleClient();
}
