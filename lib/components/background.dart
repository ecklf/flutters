import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutters/components/cloud.dart';
import 'package:flutters/components/core/gameobject.dart';
import 'package:flutters/flutters-game.dart';

class Background extends GameObject {
  final Gradient gradient = new LinearGradient(
    begin: Alignment.topCenter,
    colors: <Color>[
      Color(0xff0165b1),
      Color(0xffFFFFFF),
    ],
    stops: [
      0.0,
      1.0,
    ],
    end: Alignment(0, 0.9),
  );
  Rect rect;
  Paint paint;
  Background(FluttersGame game, double x, double y, double width, double height)
      : super(game) {
    paint = Paint();
    paint.color = Color(0xff77b5e1);

    rect = Rect.fromLTWH(x, y, width, height);
    paint = new Paint()..shader = gradient.createShader(rect);
    this.addChild(new Cloud(this.game, 0, game.tileSize * 1.7));
    this.addChild(new Cloud(this.game, 0, game.tileSize * 4.4));
  }

  @override
  void render(Canvas c) {
    c.drawRect(rect, paint);
    super.render(c);
  }

  @override
  void update(double t) {
    super.update(t);
  }
}
