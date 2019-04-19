import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutters/components/core/gameobject.dart';
import 'package:flutters/components/core/renderable.dart';
import 'package:flutters/flutters-game.dart';

class Bird extends GameObject implements Renderable {
  Bird(FluttersGame game, double x, double y, double width, double height)
      : super(game, x, y, width, height);

  @override
  void render(Canvas c) {
    Paint paint = Paint();
    paint.color = Color(0xffff0000);
    Rect rect = Rect.fromLTWH(x, y, width, height);
    c.drawRect(rect, paint);
  }

  @override
  void update(double t) {
    // TODO: implement update
  }
}
