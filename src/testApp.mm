#include "testApp.h"
using namespace std;

//--------------------------------------------------------------
void testApp::setup(){
  ofRegisterTouchEvents(this);
  
  ofxAccelerometer.setup();
  
  ofxiPhoneAlerts.addListener(this);
  
  ofBackground(000, 000, 000);
  // 初期化
  CELL_PX = DISP_SIZE / MAX_CELL_SIZE;
  // 縦 * 横の数を用意
  for (int i = 0; i < sizeof(cell_data) / sizeof(cell_data[0]); i++)
  {
    // ランダムで生成
    cell_data[i] = 0;
    int r = rand() % 6;
    if (r == 3) {
      cell_data[i] = 1;
    }
  }
  font.loadFont("arial.ttf", 12);
 
  //アルファチャンネル(透明度)を使用可能に
  
  ofSetFrameRate(1);
}
/*
 -1,-1 | -1, 0 | -1, +1
  0,-1 |  0, 0 |  0, +1
 +1,-1 | +1, 0 | +1, +1
*/
//--------------------------------------------------------------
void testApp::update(){
  int n = 0;
  int cell_data_count = sizeof(cell_data) / sizeof(cell_data[0]);
  int tmp_data[cell_data_count]; // 生死チェック用
  for (int i = 0; i < cell_data_count; i++)
  {
    n = 0;
    // コピー
    tmp_data[i] = cell_data[i];
    // 行
    for(int row = -1; row < 2; row++) {
      // 列
      for (int col = -1; col < 2; col++) {
        // 0,0 は真ん中、自分
        if (row == 0 and col == 0) continue;
        // チェック対象セル
        int cell = i + row * MAX_CELL_SIZE + col;
        if (cell >= 0 and cell < cell_data_count) {
          if ((i < cell and cell % MAX_CELL_SIZE != 0) or (i > cell and cell % MAX_CELL_SIZE != MAX_CELL_SIZE - 1)) {
            if (tmp_data[cell]) n++;
          }
        }
      }
    }
    if (tmp_data[i] and (n==2 or n==3)) {
      cell_data[i] = 1;// live
    }else if(!tmp_data[i] and n==3) {
      cell_data[i] = 1;// live
    }else{
      cell_data[i] = 0;// dead
    }
  }
}

//--------------------------------------------------------------
void testApp::draw(){
  // FPS
  ofSetColor(185, 155, 100);
  string str = "fps: ";
  str += ofToString(ofGetFrameRate(), 2)+"fps";
  font.drawString(str,100, 26);
 
  generation++;
  string gen_str = "gen: ";
  gen_str += ofToString(generation, 2);
  font.drawString(gen_str,100, 40);
 
  
  ofEnableAlphaBlending();	// アルファブレンディングを開始
  //混色を、加算混色に
  glBlendFunc(GL_ONE, GL_ONE);
  ofSetColor(102,255,102,87);	// 透明度50％
  ofFill();
  int sum = 0;
  for (int i = 0; i < sizeof(cell_data) / sizeof(cell_data[0]); i++)
  {
    if (cell_data[i] < 1) continue;
    // セル描画
    int x = (i % MAX_CELL_SIZE) * CELL_PX;
    int y = (i / MAX_CELL_SIZE) * CELL_PX;
    ofRect(x + 10, y + 50, CELL_PX - 1, CELL_PX  -1);
    sum++;
  }
  ofDisableAlphaBlending(); //終了
}

//--------------------------------------------------------------
void testApp::exit(){

}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void testApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void testApp::lostFocus(){

}

//--------------------------------------------------------------
void testApp::gotFocus(){

}

//--------------------------------------------------------------
void testApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void testApp::deviceOrientationChanged(int newOrientation){

}