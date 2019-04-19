import 'dart:math';
import 'dart:ui';

import 'package:flutters/components/core/gameobject.dart';
import 'package:flutters/components/core/renderable.dart';
import 'package:flutters/flutters-game.dart';

class Obstacle extends GameObject implements Renderable {
  final Random rng = new Random();

  Rect rect;
  Paint paint;
  bool isMoving;
  int direction;
  double movementSpeed;

  Obstacle(FluttersGame game, double x, double y, double width, double height,
      bool isMoving)
      : super(game, x, y, width, height) {
    this.isMoving = isMoving;
    movementSpeed = game.viewport.width / 4;
    // Make a random isMoving direction
    direction = rng.nextBool() == true ? 1 : -1;
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
    paint.color = Color(0xffff5a5f);
  }

  Rect toRect() {
    return Rect.fromLTWH(x, y, width, height);
  }
}
