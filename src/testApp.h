#pragma once

#include "ofMain.h"
#include "ofxiOS.h"
#include "ofxiOSExtras.h"

class testApp : public ofxiOSApp{

public:
  void setup();
  void update();
  void draw();
  void exit();

  void touchDown(ofTouchEventArgs & touch);
  void touchMoved(ofTouchEventArgs & touch);
  void touchUp(ofTouchEventArgs & touch);
  void touchDoubleTap(ofTouchEventArgs & touch);
  void touchCancelled(ofTouchEventArgs & touch);

  void lostFocus();
  void gotFocus();
  void gotMemoryWarning();
  void deviceOrientationChanged(int newOrientation);
 
  // ここから
  int MAX_CELL_SIZE = 20; // セルのサイズ
  int DISP_SIZE = 200; // 画面サイズ 360px
  int CELL_PX;   // 1辺のピクセル数
  int cell_data[400];  // セルの情報配列
  int generation = 0; // 世代
  ofImage img;
private:
  ofTrueTypeFont font;
};