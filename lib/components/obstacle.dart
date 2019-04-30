import 'dart:math';
import 'dart:ui';

import 'package:flutters/components/core/gameobject.dart';
import 'package:flutters/flutters-game.dart';

class Obstacle extends GameObject {
  final Random rng = new Random();

  Rect rect;
  Paint paint;

  double x;
  double y;
  double width;
  double height;

  bool isMoving;
  int direction;
  double movementSpeed;

  Obstacle(
      FluttersGame game, this.x, this.y, this.width, this.height, this.isMoving)
      : super(game) {
    movementSpeed = game.viewport.width / 4;
    direction = rng.nextBool() == true ? 1 : -1;
    paint = Paint();
    paint.color = Color(0xff3D4852);
  }

  @override
  void render(Canvas c) {
    rect = Rect.fromLTWH(x, y, width, height);
    c.drawRect(rect, paint);
  }

  @override
  void update(double t) {
    if (isMoving) {
      checkCollision();
      x += direction * movementSpeed * t;
    }
  }

  void checkCollision() {
    if (x >= game.viewport.width - width) {
      direction = -1;
    } else if (x <= 0) {
      direction = 1;
    }
  }

  void markHit() {
    paint.color = Color(0xffEF5753);
  }

  Rect toRect() {
    return Rect.fromLTWH(x, y, width, height);
  }
}
