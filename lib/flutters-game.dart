import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:flutters/components/background.dart';
import 'package:flutters/components/bird.dart';
import 'package:flutters/components/dialog.dart';
import 'package:flutters/components/floor.dart';
import 'package:flutters/components/level.dart';
import 'package:flutters/components/obstacle.dart';
import 'package:flutters/components/text.dart';
import 'package:url_launcher/url_launcher.dart';

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
  TextComponent scoreText;
  TextComponent floorText;
  Dialog gameOverDialog;

  double tileSize;
  double birdPosY;
  double birdPosYOffset = 8;
  bool isFluttering = false;
  double flutterValue = 0;
  double flutterIntensity = 20;
  double floorHeight = 250;
  // Game Score
  double currentHeight = 0;
  FluttersGame(screenDimensions) {
    resize(screenDimensions);
    skyBackground = Background(this, 0, 0, viewport.width, viewport.height);
    groundFloor = Floor(this, 0, viewport.height - floorHeight, viewport.width,
        floorHeight, 0xff48BB78);
    currentLevel = Level(this);
    birdPlayer = Bird(this, 0, birdPosY, tileSize, tileSize);
    scoreText = TextComponent(this, '0', 30.0, 60);
    floorText = TextComponent(
        this, 'Tap to flutter!', 40.0, viewport.height - floorHeight / 2);
    gameOverDialog = Dialog(this);
  }

  void resize(Size size) {
    viewport = size;
    tileSize = viewport.width / 6;
    birdPosY = viewport.height - floorHeight - tileSize + (tileSize / 8);
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

    if (currentGameState == GameState.gameOver) {
      gameOverDialog.render(c);
    } else {
      scoreText.render(c);
    }
  }

  void update(double t) {
    if (currentGameState == GameState.playing) {
      currentLevel.levelObstacles.forEach((obstacle) {
        if (isObstacleInRange(obstacle)) {
          obstacle.update(t);
        }
      });
      skyBackground.update(t);
      birdPlayer.update(t);
      // Update scoreText
      scoreText.setText(currentHeight.floor().toString());
      scoreText.update(t);
      floorText.update(t);
      gameOverDialog.update(t);
      // Game tasks
      flutterHandler();
      checkCollision();
    }
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

  void restartGame() {
    birdPlayer.setRotation(0);
    currentHeight = 0;
    currentLevel.generateObstacles();
    currentGameState = GameState.playing;
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
    if (currentGameState != GameState.gameOver) {
      // Make the bird flutter
      birdPlayer.startFlutter();
      isFluttering = true;
      flutterValue = flutterIntensity;
      return;
    }
    if (gameOverDialog.playButton.contains(d.globalPosition)) {
      restartGame();
    }
    if (gameOverDialog.creditsText.toRect().contains(d.globalPosition)) {
      _launchURL();
    }
  }

  void onTapUp(TapUpDetails d) {
    birdPlayer.endFlutter();
  }

  _launchURL() async {
    const url = 'https://github.com/impulse';
    await launch(url);
  }
}
