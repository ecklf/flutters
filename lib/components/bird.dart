import 'dart:ui';
import 'dart:math' as math;

import 'package:flame/sprite.dart';
import 'package:flutter/rendering.dart';
import 'package:flutters/components/core/gameobject.dart';
import 'package:flutters/flutters-game.dart';

class Bird extends GameObject {
  final List<List<Sprite>> characterSprites = [
    [Sprite('bird-0.png'), Sprite('bird-1.png')],
    [Sprite('bird-0-left.png'), Sprite('bird-1-left.png')]
  ];

  Rect rect;
  Paint paint;

  double collisionToleranceX;
  double collisionToleranceY;

  double x;
  double y;
  double width;
  double height;
  double rotation;

  int direction = 1;
  int characterSpritesIndex = 0;
  int flutterFrame = 0;
  double movementSpeed;

  Bird(FluttersGame game, this.x, this.y, this.width, this.height,
      [this.rotation = 0])
      : super(game) {
    collisionToleranceX = game.tileSize / 5;
    collisionToleranceY = game.tileSize / 6;
    movementSpeed = game.viewport.width / 2;
  }

  @override
  void render(Canvas c) {
    paint = Paint();
    // Transparent bounding box
    paint.color = Color(0x00000000);
    rect = Rect.fromLTWH(0, 0, width, height);
    c.save();
    c.translate(x, y);
    c.translate(width / 2, height / 2);
    c.rotate(rotation);
    c.translate(-width / 2, -height / 2);
    c.drawRect(rect, paint);
    characterSprites[characterSpritesIndex][flutterFrame]
        .renderRect(c, rect.inflate(0));
    c.restore();
  }

  @override
  void update(double t) {
    checkCollision();
    x += direction * movementSpeed * t;
  }

  void setRotation(double deg) {
    rotation = deg * math.pi / 180;
  }

  void checkCollision() {
    if (x >= game.viewport.width - width) {
      direction = -1;
      characterSpritesIndex = 1;
    } else if (x <= 0) {
      direction = 1;
      characterSpritesIndex = 0;
    }
  }

  void startFlutter() {
    flutterFrame = 1;
  }

  void endFlutter() {
    flutterFrame = 0;
  }

  Rect toRect() {
    return Rect.fromLTWH(x, y, width, height);
  }

  Rect toCollisionRect() {
    double left = x;
    double right = x + width;
    double top = y - game.currentHeight;
    double bottom = y - game.currentHeight + height;

    return Rect.fromLTRB(left + collisionToleranceX, top + collisionToleranceX,
        right - collisionToleranceX, bottom - collisionToleranceY);
  }
}
