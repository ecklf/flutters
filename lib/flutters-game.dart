import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:flutters/components/background.dart';
import 'package:flutters/components/bird.dart';
import 'package:flutters/components/obstacle.dart';

class FluttersGame extends Game {
  Size viewport;
  Background skyBackground;
  Bird birdPlayer;
  Obstacle testObj;

  FluttersGame() {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
    skyBackground = Background(this, 0, 0, viewport.width, viewport.height);
    birdPlayer = Bird(this, 20, 300, 50, 50);
    testObj = Obstacle(this, 20, 20, 100, 100, false);
  }

  void render(Canvas c) {
    skyBackground.render(c);
    birdPlayer.render(c);
    testObj.render(c);
  }

  void update(double t) {}

  void resize(Size size) {
    viewport = size;
  }

  void onTapDown(TapDownDetails d) {
    birdPlayer.startFlutter();
    print('work');
  }

  void onTapUp(TapUpDetails d) {
    birdPlayer.endFlutter();
  }
}
