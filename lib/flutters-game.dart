import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:flutters/components/obstacle.dart';

class FluttersGame extends Game {
  Size viewport;
  Obstacle testObj;

  FluttersGame() {
    testObj = Obstacle(this, 20, 20, 100, 100);
  }

  void render(Canvas c) {
    testObj.render(c);
  }

  void update(double t) {}

  void resize(Size size) {
    viewport = size;
  }

  void onTapDown(TapDownDetails d) {
    print('work');
  }

  void onTapUp(TapUpDetails d) {}
}
