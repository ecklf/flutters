import 'dart:ui';

import 'package:flutter/painting.dart';
import 'package:flutters/components/core/renderable.dart';
import 'package:flutters/flutters-game.dart';

class Text implements Renderable {
  final FluttersGame game;
  TextPainter painter;
  TextStyle textStyle;
  String textValue;
  double posY;
  Offset position;

  Text(this.game, String text, double fontSize, double posY) {
    this.textValue = text;
    this.posY = posY;
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textStyle = TextStyle(
      fontFamily: 'Baloo',
      color: Color(0xfffafafa),
      fontSize: fontSize,
    );
    position = Offset.zero;
  }

  void setText(String text) {
    this.textValue = text;
  }

  @override
  void render(Canvas c) {
    painter.paint(c, position);
  }

  @override
  void update(double t) {
    if ((painter.text?.text ?? '') != textValue) {
      painter.text = TextSpan(
        text: textValue,
        style: textStyle,
      );
      painter.layout();
      position = Offset(
        (game.viewport.width / 2) - (painter.width / 2),
        posY - (painter.height / 2),
      );
    }
  }
}
