import java.lang.String;
import com.pubnub.api.*;
import org.slf4j.*;
import org.json.*;
import java.io.File;
import java.io.FileReader;
import java.io.FileNotFoundException;

Pubnub pubnub;

PImage img;
int cindex = 0;
float nindex = 0;
String name;

String newName = "";
int nameCount = 0;

String[] vowels = {"a","e","i","o","u","A","E","I","O","U"};

PImage[] imgs;
PImage[] blurred_imgs;


color[] colours = {#0a1c20, #41a6de, #fedb0e, #f6343c, #471BAE, #FF6C41, #FFCB41, #515FE3};

ArrayList<String> names = new ArrayList();

void setup() {

  fullScreen();
  frameRate(6);
  loadImgs();
  PFont bangers = createFont("Bangers.ttf", 24);
  textFont(bangers);
  textAlign(CENTER, CENTER);
  String[] seednames = {"Samira Wiley", "Alan Turing", "Laura Jane Grace", "Sara Quin", "Tegan Quin", "Kristen Stewart", "Tyler Oakley", "Hannah Hart", "Chris Colfer", "Helen Marukh", "Korey Kuhl", "Ingrid Nilsen", "Troye Sivan", "Neil Patrick Harris", "Kathryn Moenig", "Ellen Degeneres", "Ellen Page"};
  for(int i = 0; i < seednames.length; i++) {
    names.add(seednames[i]);
  }
  
  File cfg = new File(dataPath("config.txt"));
  try {
   BufferedReader br = new BufferedReader(new FileReader(dataPath("config.txt")));

  String pub = br.readLine().trim();
  String sub = br.readLine().trim();
  pubnub = new Pubnub(pub, sub);

 
    pubnub.subscribe("entries", new Callback() {
        @Override
        public void connectCallback(String channel, Object message) {
            //pubnub.publish("entries", "Hello from processing", new Callback() {});
        }
   
        @Override
        public void disconnectCallback(String channel, Object message) {
            System.out.println("SUBSCRIBE : DISCONNECT on channel:" + channel
                       + " : " + message.getClass() + " : "
                       + message.toString());
        }
   
        public void reconnectCallback(String channel, Object message) {
            System.out.println("SUBSCRIBE : RECONNECT on channel:" + channel
                       + " : " + message.getClass() + " : "
                       + message.toString());
        }
   
        @Override
        public void successCallback(String channel, Object message) {
            System.out.println("SUBSCRIBE : " + channel + " : "
                       + message.getClass() + " : " + message.toString());
            newName(message.toString());
        }
   
        @Override
        public void errorCallback(String channel, PubnubError error) {
            System.out.println("SUBSCRIBE : ERROR on channel " + channel
                       + " : " + error.toString());
        }
      }
    );
  } catch (PubnubException e) {
    System.out.println(e.toString());
  } catch (IOException e) {
    println("io error");
  }
}

void newName(String name) {
  names.add(name);
  newName = name;
}

void loadImgs() {
  String[] fnames = {"1","2","3","4","5","6","7","8","9","10","11","bubble", "kapow", "kaboom", "blast1", "blast3", "blast2", "blast7", "blast4", "blast8", "blast5", "blast", "speech4", "speech1", "speech5", "speech3", "thought"};
  imgs = new PImage[fnames.length];
  blurred_imgs = new PImage[fnames.length];
  
  for (int i = 0; i < fnames.length; i++) {
    imgs[i] = loadImage("/home/natalie/nuitrose/" + fnames[i] + ".png");
    blurred_imgs[i] = blur(imgs[i]);
  }
  tint(255, 126);
}

boolean vowel(String n) {
  for(int i = 0; i < vowels.length; i++) {
    if(vowels[i] == n) {
      return true;
    }
  }
  return false;
}

void subtleBubbles(int h, String n) {
   float tr = map(("LGBTQ+" + n).hashCode(), -2147483648, 2147483647, 100,200);

  fill(0,0,0,tr);
 
  int index;
  float x, y;
  if (h >= 0 ) {
    index = abs(h)%imgs.length;
    img = imgs[index].copy();
  } else {
    index = abs(h)%imgs.length;
    img = blurred_imgs[index].copy();
  }
  float ii = hashMap(h, 0.25, 0.75);
  if (n.length() % 2 == 0) {

    img.resize(int(img.width*ii), int(img.height*ii)); 
    x = hpos(h, 0, width)-img.width/2;
    y = vpos(h, -100, height)-img.height/2;
    image(img, x, y);
  } else {
      pushMatrix();

    scale(-1, 1);
    img.resize(int(img.width*ii), int(img.height*ii)); 
    popMatrix();
    x = hpos(h,0,width) - img.width/2;
    y = vpos(h, -100, height)-img.height/2;
    image(img, x, y);
  }
}

void conspicuousBubbles(int h, String n, String name) {
  float tr = map(("LGBTQ+" + n).hashCode(), -2147483648, 2147483647, 100,200);

  fill(0,0,0,tr);
 
  int index;
  float x, y;
  if (h >= 0 ) {
    index = abs(h)%imgs.length;
    img = imgs[index].copy();
  } else {
    index = abs(h)%imgs.length;
    img = blurred_imgs[index].copy();
  }
  float ii = hashMap(h, 0.25, 1.5);
  if (n.length() % 2 == 0) {

    img.resize(int(img.width*ii), int(img.height*ii)); 
    x = hpos(h, 0, width)-img.width/2;
    y = vpos(h, -100, height)-img.height/2;
    image(img, x, y);
  } else {
      pushMatrix();

    scale(-1, 1);
    img.resize(int(img.width*ii), int(img.height*ii)); 
    popMatrix();
    x = hpos(h,0,width) - img.width/2;
    y = vpos(h, -100, height)-img.height/2;
    image(img, x, y);
  }
}

void bubblesRepeat(int h, String n, String name){
    float tr = map(("LGBTQ+" + n).hashCode(), -2147483648, 2147483647, 100,200);

  fill(0,0,0,tr);
 
  int index;
  float x, y;
  if (h >= 0 ) {
    index = abs(h)%imgs.length;
    img = imgs[index].copy();
  } else {
    index = abs(h)%imgs.length;
    img = blurred_imgs[index].copy();
  }
  float ii = hashMap(h, 0.25, 1.5);
  if (n.length() % 2 == 0) {

    img.resize(int(img.width*ii), int(img.height*ii)); 
    for(int k = -1; k < width/(img.width/2.0);k++){
      for(int kk = -1; kk < height/(img.height/2.0);kk++){
              image(img, k*img.width/2.0, kk*img.height/2.0);

      }
    }
 
  } else {
      pushMatrix();

    scale(-1, 1);
    img.resize(int(img.width*ii), int(img.height*ii)); 
    popMatrix();
    for(int k = -1; k < width/(img.width/2.0);k++){
      for(int kk = -1; kk < height/(img.height/2.0);kk++){
        image(img, k*img.width/2.0, kk*img.height/2.0);
      }
    }    
  }
}

void showLetters(String l, int h) {
  float ii = hashMap(h, 0.25, 1.5);
  textSize(48*ii);
  text(l, hpos(h, 0, width), vpos(h, 0, height));
}

PImage blur(PImage pin) {
  PImage pout = pin.copy();
  for (int i = 0; i < 5; i++) {
    pout.resize(pin.width/10, pin.height/10);
    pout.resize(pin.width, pin.width);
  }
  return pout;
}

float hashMap(int h, float min, float max ) {
  return map(h, -2147483648, 2147483647, min, max);
}

float hpos(int h, float min, float max) {
  
  if(random(10) > 9) {
    float third = (max - min) * 0.33;
   
    if(h % 2 == 0) {
     third  = third * 2;
    }
    return min + map(h, -2147483648, 2147483647, third - 0.5, third + 0.5);  
  }  else {
     return random(min, max); 
  }
  
}

float vpos(int h, float min, float max) {
  
  if(random(10)>9){
    float third = (max - min) * 0.33;
    if(h % 2 == 0) {
     third  = third * 2;
    }
    return min + map(h, -2147483648, 2147483647, third - 0.5, third + 0.5);
  } else {
     return random(min, max); 
  }
}

void mousePressed() {
  newName("Natalie");
}

void draw() {  
  background(colours[(cindex++/10)%colours.length]);
  if(newName != "") {
    name = newName;
  } else {
    nindex = ((nindex + 1) % names.size());
    name = names.get(int(nindex));
  }
  int h = name.hashCode();
  String[] letters = name.split("");
  for(int j = 0; j < letters.length - 1; j++) {
  if(newName != "") {
    conspicuousBubbles((letters[j]+letters[j+1]).hashCode(), letters[j] + letters[j+1], letters[j]);
    showLetters(letters[j], letters[j].hashCode());
  } else {
    subtleBubbles((letters[j]+letters[j+1]).hashCode(), letters[j] + letters[j+1]);

  }
 
}
  if(newName != "") {
   newNameAction(h);
  }
}

void newNameAction(int h) {
   nameCount++;
    bubblesRepeat(h+nameCount, name, "");
    nameCount = nameCount % 21;

    if(nameCount == 0) {
      newName = "";
    }
}