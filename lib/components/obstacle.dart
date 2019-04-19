import 'dart:ui';

import 'package:flutters/components/common/gameobject.dart';
import 'package:flutters/components/common/renderable.dart';
import 'package:flutters/flutters-game.dart';

class Obstacle extends GameObject implements Renderable {
  Obstacle(FluttersGame game, double x, double y, double width, double height)
      : super(game, x, y, width, height) {}

  @override
  void render(Canvas c) {
    Rect rect = Rect.fromLTWH(x, y, width, height);
    Paint paint = Paint();
    paint.color = Color(colorCode);
    c.drawRect(rect, paint);
  }

  @override
  void update(double t) {
    // TODO: implement update
  }
}
