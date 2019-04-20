import 'dart:ui';

import 'package:flutters/components/core/gameobject.dart';
import 'package:flutters/components/text.dart';
import 'package:flutters/flutters-game.dart';

class Dialog extends GameObject {
  final FluttersGame game;
  Paint paint;
  Rect wrapper;
  RRect wrapperBox;
  TextComponent titleText;
  TextComponent scoreText;
  TextComponent buttonText;
  TextComponent creditsText;

  Dialog(this.game) : super(game) {
    double paddingX = 0.1;
    double paddingY = 0.25;

    double rectLeft = game.viewport.width * paddingX;
    double rectTop = game.viewport.height * paddingY;
    double rectWidth = game.viewport.width * (1 - paddingX * 2);
    double rectHeight = game.viewport.height * (1 - paddingY * 2);

    wrapper = Rect.fromLTWH(rectLeft, rectTop, rectWidth, rectHeight);
    wrapperBox = RRect.fromRectAndRadius(wrapper, Radius.circular(4));

    paint = Paint();
    paint.color = Color(0xfffafafa);

    titleText =
        TextComponent(game, 'Game Over!', 45.0, rectTop + 50, 0xff484848);
    // scoreText =
    //     TextComponent(game, 'Score', 30.0, rectTop + 100, 0xff000000);
    // buttonText =
    //     TextComponent(game, 'Play again', 30.0, rectTop + 150, 0xff000000);
    // creditsText = TextComponent(
    //     game, 'Made with ❤️ by @impulse', 30.0, rectTop + 200, 0xff000000);
  }

  @override
  void render(Canvas c) {
    c.drawRRect(wrapperBox, paint);
    titleText.render(c);
  }

  @override
  void update(double t) {
    titleText.update(t);
    // TODO: implement update
  }
}
