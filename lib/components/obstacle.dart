import 'dart:ui';

import 'package:flutters/components/core/gameobject.dart';
import 'package:flutters/components/core/renderable.dart';
import 'package:flutters/flutters-game.dart';

class Obstacle extends GameObject implements Renderable {
  bool isMoving;
  Rect rect;
  Paint paint;

  Obstacle(FluttersGame game, double x, double y, double width, double height,
      bool isMoving)
      : super(game, x, y, width, height) {
    this.isMoving = isMoving;

    paint = Paint();
    paint.color = Color(colorCode);
  }

  @override
  void render(Canvas c) {
    rect = Rect.fromLTWH(x, y, width, height);
    c.drawRect(rect, paint);
  }

  @override
  void update(double t) {
    // TODO implement update
  }

  void markHit() {
    paint.color = Color(0xffff0000);
  }

  Rect toRect() {
    return Rect.fromLTWH(x, y, width, height);
  }
}
