import 'dart:ui';

import 'package:flutters/components/core/gameobject.dart';
import 'package:flutters/components/core/renderable.dart';
import 'package:flutters/flutters-game.dart';

class Floor extends GameObject implements Renderable {
  Rect rect;

  Floor(FluttersGame game, double x, double y, double width, double height,
      int colorCode)
      : super(game, x, y, width, height) {
    this.colorCode = colorCode;
  }

  @override
  void render(Canvas c) {
    rect = Rect.fromLTWH(x, y, width, height);
    Paint paint = Paint();
    paint.color = Color(colorCode);
    c.drawRect(rect, paint);
  }

  @override
  void update(double t) {
    // TODO: implement update
  }
}
