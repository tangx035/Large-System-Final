int water =150;
int x = 100;
PImage cupImg, bgImg;

// endpoint
String baseUrl = "149.31.125.61:3000/";
// api
String setUrl = baseUrl + "set-water?water=";
String getUrl = baseUrl + "get-water";
String text;

void updateScoreOnServer(int water) {
  loadJSONObject(setUrl + water);
  return;
}

int scoreFromServer() {
 JSONObject serverScore = loadJSONObject(getUrl);
 int temp = serverScore.getInt("water");
 return temp;
}

void setup(){
  size(400,400);
  background(0);
  cupImg = loadImage("cup.png");
  bgImg = loadImage("bg.png");
  //text = "This Glass is too empty. Click to fill it up";
  text = "This Glass is too full. Click to drink it up";
}

void draw(){
  water = scoreFromServer();
  image(bgImg,0,0,width,height);
  
  //draw water
  rectMode(CORNERS);
  noStroke();
  fill(100,220,240);
  rect(100, water, 300, 350);
  
  image(cupImg,0,0,width,height);
  
  fill(100);
  textSize(16);
  textAlign(CENTER);
  text(text, width/2, 25);
  
  if(water > 350){
    water = 350;
    //text = "Glass all empty! You have given up";
    text = "Glass all empty! You have perservered";
  } else if(water <50){
    water = 50;
    //text = "Glass all full! You have persevered";
    text = "Glass all full! You have given up";
  }
  
}

void mouseClicked(){
  //water-=5; 
  water+=5;
  updateScoreOnServer(water);
}

void keyPressed(){
 if( key =='r'){
   text = "This Glass is too empty. Click to fill it up";
  water = height/2;
  updateScoreOnServer(water);
 }
}