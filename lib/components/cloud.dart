import 'dart:math';
import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutters/components/core/gameobject.dart';
import 'package:flutters/flutters-game.dart';

class Cloud extends GameObject {
  final Random rng = new Random();
  final List<Sprite> cloudSprites = [
    Sprite('cloud-1.png'),
    Sprite('cloud-2.png'),
    Sprite('cloud-3.png')
  ];

  Rect rect;
  Paint paint;

  double x;
  double y;
  double width = 100;
  double height = 100;

  int direction;
  int cloudType;
  double speedRng;
  double movementSpeed;

  Cloud(FluttersGame game, this.x, this.y) : super(game) {
    x = rng.nextDouble() * game.viewport.width;
    movementSpeed = rng.nextDouble() * game.viewport.width / 4;
    cloudType = rng.nextInt(2);
    direction = rng.nextBool() == true ? 1 : -1;
  }

  @override
  void render(Canvas c) {
    paint = Paint();
    // Transparent bounding box
    paint.color = Color(0x00000000);
    width = game.tileSize / 5 * (533 / 100);
    height = game.tileSize / 5 * (185 / 100);
    rect = Rect.fromLTWH(x, y, width, height);
    c.drawRect(rect, paint);
    cloudSprites[cloudType].renderRect(c, rect.inflate(0));
  }

  @override
  void update(double t) {
    checkCollision();
    x += direction * movementSpeed * t;
  }

  void checkCollision() {
    if (x >= game.viewport.width - width) {
      direction = -1;
    } else if (x <= 0) {
      direction = 1;
    }
  }
}
