import 'dart:math';
import 'package:flutters/components/obstacle.dart';
import 'package:flutters/flutters-game.dart';

class Level {
  final FluttersGame game;
  List<Obstacle> levelObstacles;
  final Random rng = new Random();

  Level(this.game) {
    generateObstacles();
  }

  void generateObstacles() {
    levelObstacles = List<Obstacle>();
    Obstacle obstacle;
    bool isLeft;
    double randomWidth;
    double randomHeight;
    double posX;
    double posY;
    for (int i = 2; i < 10; i++) {
      randomWidth = (rng.nextDouble() * 30) + 10;
      randomHeight = (rng.nextDouble() * 100) + 70;
      isLeft = rng.nextBool();
      posY = ((-i * 300) + game.viewport.height);
      if (isLeft) {
        posX = 0;
      } else {
        posX = game.viewport.width - randomWidth;
      }
      obstacle = Obstacle(game, posX, posY, randomWidth, randomHeight, false);
      // Add obstacles to level
      levelObstacles.add(obstacle);
    }
  }
}
