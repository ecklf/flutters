import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:flutters/components/background.dart';
import 'package:flutters/components/bird.dart';
import 'package:flutters/components/dialog.dart';
import 'package:flutters/components/floor.dart';
import 'package:flutters/components/level.dart';
import 'package:flutters/components/obstacle.dart';
import 'package:flutters/components/text.dart';

enum GameState {
  playing,
  gameOver,
}

class FluttersGame extends Game {
  GameState currentGameState = GameState.playing;
  Size viewport;
  Background skyBackground;
  Floor groundFloor;
  Level currentLevel;
  Bird birdPlayer;
  TextRenderable scoreText;
  TextRenderable floorText;
  Dialog gameOverDialog;

  double characterSize;
  double birdPosY;
  double birdPosYOffset = 8;
  bool isFluttering = false;
  double flutterValue = 0;
  double flutterIntensity = 20;
  double floorHeight = 250;
  // Game Score
  double currentHeight = 0;
  FluttersGame() {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
    skyBackground = Background(this, 0, 0, viewport.width, viewport.height);
    groundFloor = Floor(this, 0, viewport.height - floorHeight, viewport.width,
        floorHeight, 0xff48BB78);
    currentLevel = Level(this);
    birdPlayer = Bird(this, 0, birdPosY, characterSize, characterSize);
    scoreText = TextRenderable(this, '0', 30.0, 60);
    floorText = TextRenderable(
        this, 'Tap to flutter!', 40.0, viewport.height - floorHeight / 2);
    gameOverDialog = Dialog(this);
  }

  void resize(Size size) {
    viewport = size;
    characterSize = viewport.width / 6;
    birdPosY = viewport.height - floorHeight - characterSize + birdPosYOffset;
  }

  void render(Canvas c) {
    skyBackground.render(c);
    c.save();
    c.translate(0, currentHeight);
    currentLevel.levelObstacles.forEach((obstacle) {
      if (isObstacleInRange(obstacle)) {
        obstacle.render(c);
      }
    });
    groundFloor.render(c);
    floorText.render(c);
    c.restore();

    birdPlayer.render(c);
    scoreText.render(c);

    // TODO: move into gameOver state
    if (currentGameState == GameState.gameOver) {}
    // gameOverDialog.render(c);
  }

  void update(double t) {
    currentLevel.levelObstacles.forEach((obstacle) {
      if (isObstacleInRange(obstacle)) {
        obstacle.update(t);
      }
    });
    birdPlayer.update(t);
    // Update scoreText
    scoreText.setText(currentHeight.floor().toString());
    scoreText.update(t);
    floorText.update(t);
    // Game tasks
    flutterHandler();
    checkCollision();
  }

  void checkCollision() {
    currentLevel.levelObstacles.forEach((obstacle) {
      if (isObstacleInRange(obstacle)) {
        if (birdPlayer.toCollisionRect().overlaps(obstacle.toRect())) {
          obstacle.markHit();
          gameOver();
        }
      }
    });
  }

  void gameOver() {
    currentGameState = GameState.gameOver;
  }

  bool isObstacleInRange(Obstacle obs) {
    if (-obs.y < viewport.height + currentHeight &&
        -obs.y > currentHeight - viewport.height) {
      return true;
    } else {
      return false;
    }
  }

  void flutterHandler() {
    if (isFluttering) {
      flutterValue = flutterValue * 0.8;
      currentHeight += flutterValue;
      birdPlayer.setRotation(-flutterValue * birdPlayer.direction * 1.5);
      // Cut the jump below 1 unit
      if (flutterValue < 1) isFluttering = false;
    } else {
      // If max. fallspeed not yet reached
      if (flutterValue < 15) {
        flutterValue = flutterValue * 1.2;
      }
      if (currentHeight > flutterValue) {
        birdPlayer.setRotation(flutterValue * birdPlayer.direction * 2);
        currentHeight -= flutterValue;
        // stop jumping below floor
      } else if (currentHeight > 0) {
        currentHeight = 0;
        birdPlayer.setRotation(0);
      }
    }
  }

  void onTapDown(TapDownDetails d) {
    // Make the bird flutter
    birdPlayer.startFlutter();
    isFluttering = true;
    flutterValue = flutterIntensity;
    // TODO
    // if (currentGameState == GameState.gameOver &&
    //     gameOverDialog.buttonRect.contains(d.globalPosition)) {
    //   restartGame();
    // }
  }

  void onTapUp(TapUpDetails d) {
    birdPlayer.endFlutter();
  }
}
