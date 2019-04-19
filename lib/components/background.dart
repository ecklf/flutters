import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutters/components/core/gameobject.dart';
import 'package:flutters/components/core/renderable.dart';
import 'package:flutters/flutters-game.dart';

class Background extends GameObject implements Renderable {
  Background(FluttersGame game, double x, double y, double width, double height)
      : super(game, x, y, width, height);

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

  @override
  void render(Canvas c) {
    Paint paint = Paint();
    paint.color = Color(0xff77b5e1);
    Rect rect = Rect.fromLTWH(x, y, width, height);
    paint = new Paint()..shader = gradient.createShader(rect);
    c.drawRect(rect, paint);
  }

  @override
  void update(double t) {
    // TODO: implement update
  }
}
