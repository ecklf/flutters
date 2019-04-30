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

  int direction;
  double movementSpeed;

  Cloud(FluttersGame game, this.x, this.y)
      : super(game) {
    movementSpeed = game.viewport.width / 4;
    direction = rng.nextBool() == true ? 1 : -1;
  }

  @override
  void render(Canvas c) {
    paint = Paint();
    // Transparent bounding box
    paint.color = Color(0x00000000);
    rect = Rect.fromLTWH(
        x,
        y,
        game.tileSize / 5 * (cloudSprites[0].size.x / 100),
        game.tileSize / 5 * (cloudSprites[0].size.y / 100));
    c.drawRect(rect, paint);
    cloudSprites[0].renderRect(c, rect.inflate(0));
  }

  @override
  void update(double t) {
    print('running');
    checkCollision();
    x += direction * movementSpeed * t;
  }

  void checkCollision() {
    if (x >= game.viewport.width - rect.width) {
      direction = -1;
    } else if (x <= 0) {
      direction = 1;
    }
  }
}
