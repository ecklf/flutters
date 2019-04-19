import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/rendering.dart';
import 'package:flutters/components/core/gameobject.dart';
import 'package:flutters/components/core/renderable.dart';
import 'package:flutters/flutters-game.dart';

class Bird extends GameObject implements Renderable {
  final List<List<Sprite>> characterSprites = [
    [Sprite('bird-0.png'), Sprite('bird-1.png')],
    [Sprite('bird-0-left.png'), Sprite('bird-1-left.png')]
  ];

  int flutterFrame = 0;

  Bird(FluttersGame game, double x, double y, double width, double height)
      : super(game, x, y, width, height);

  @override
  void render(Canvas c) {
    Paint paint = Paint();
    paint.color = Color(0xffff0000);
    Rect rect = Rect.fromLTWH(x, y, width, height);
    c.drawRect(rect, paint);
    characterSprites[0][flutterFrame].renderRect(c, rect.inflate(0));
  }

  @override
  void update(double t) {
    // TODO: implement update
  }

  void startFlutter() {
    flutterFrame = 1;
  }

  void endFlutter() {
    flutterFrame = 0;
  }
}
