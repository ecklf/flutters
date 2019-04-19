import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:flutters/components/background.dart';
import 'package:flutters/components/bird.dart';
import 'package:flutters/components/floor.dart';
import 'package:flutters/components/level.dart';

class FluttersGame extends Game {
  double currentHeight = 0;
  bool isFluttering = false;
  double flutterValue = 0;
  // TODO: magic value removal
  double flutterIntensity = 20;
  double floorHeight = 250;
  double birdPosY;
  double birdPosYOffset = 8;

  Size viewport;
  Background skyBackground;
  Floor groundFloor;
  Level currentLevel;
  Bird birdPlayer;
  double characterSize;

  FluttersGame() {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
    skyBackground = Background(this, 0, 0, viewport.width, viewport.height);
    groundFloor = Floor(this, 0, viewport.height - floorHeight, viewport.width,
        floorHeight, 0xff48BB78);
    currentLevel = Level(this);
    birdPlayer = Bird(this, 0, birdPosY, characterSize, characterSize);
  }

  void resize(Size size) {
    viewport = size;
    characterSize = viewport.width / 6;
    // birdPosY = viewport.height - floorHeight - characterSize + birdPosYOffset;
    birdPosY = viewport.height - characterSize;
  }

  void render(Canvas c) {
    skyBackground.render(c);

    c.save();
    c.translate(0, currentHeight);

    currentLevel.levelObstacles.forEach((obstacle) {
      // TODO: if (comp.position is near the currentHeight) { // no idea how PositionComponents calculate the position LOL
      obstacle.render(c);

      // }
      // print('bird ${birdPlayer.toCollisionRect()}');
      // print(obstacle.toRect());
      groundFloor.render(c);
    });
    c.restore();

    birdPlayer.render(c);
  }

  void update(double t) {
    birdPlayer.update(t);
    // Game tasks
    flutterHandler();
    checkCollision();
  }

  void checkCollision() {
    // 764.5 812
    currentLevel.levelObstacles.forEach((obstacle) {
      // print('bird ${birdPlayer.toCollisionRect()}');
      // print(obstacle.toRect());
      if (birdPlayer.toCollisionRect().overlaps(obstacle.toRect())) {
        // TODO: handle gameover
        print('woo');
      }
    });
  }

  void flutterHandler() {
    if (isFluttering) {
      flutterValue = flutterValue * 0.8;
      currentHeight += flutterValue;
      birdPlayer.setRotation(-flutterValue * birdPlayer.direction * 1.5);
      // Cut the jump below 1 unit
      if (flutterValue < 1) isFluttering = false;
    } else {
      // If max. fallspeed not yet reached
      if (flutterValue < 15) {
        flutterValue = flutterValue * 1.2;
      }
      if (currentHeight > flutterValue) {
        birdPlayer.setRotation(flutterValue * birdPlayer.direction * 2);
        currentHeight -= flutterValue;
        // stop jumping below floor
      } else if (currentHeight > 0) {
        currentHeight = 0;
        birdPlayer.setRotation(0);
      }
    }
  }

  void onTapDown(TapDownDetails d) {
    // Make the bird flutter
    birdPlayer.startFlutter();
    isFluttering = true;
    flutterValue = flutterIntensity;
  }

  void onTapUp(TapUpDetails d) {
    birdPlayer.endFlutter();
  }
}
