import 'dart:ui';

import 'package:flutters/components/core/renderable.dart';
import 'package:flutters/flutters-game.dart';

class Dialog implements Renderable {
  final FluttersGame game;
  Rect wrapper;
  RRect wrapperBox;

  Dialog(this.game);

  @override
  void render(Canvas c) {
    wrapper = Rect.fromLTWH(
        game.viewport.width * 0.1,
        game.viewport.height * 0.25,
        game.viewport.width * 0.8,
        game.viewport.height * 0.5);

    wrapperBox = RRect.fromRectAndRadius(wrapper, Radius.circular(4));

    Paint paint = Paint();
    paint.color = Color(0xfffafafa);
    c.drawRRect(wrapperBox, paint);
  }

  @override
  void update(double t) {
    // TODO: implement update
  }
}
