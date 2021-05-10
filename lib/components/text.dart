import 'dart:ui';

import 'package:flutter/painting.dart';
import 'package:flutters/components/core/gameobject.dart';
import 'package:flutters/flutters-game.dart';

class TextComponent extends GameObject {
  final FluttersGame game;
  TextPainter painter;
  TextStyle textStyle;
  String displayString;
  Offset position;
  double fontSize;
  double posY;

  TextComponent(this.game, String text, double fontSize, double posY,
      [int colorCode = 0xfffafafa])
      : super(game) {
    this.fontSize = fontSize;
    this.displayString = text;
    this.posY = posY;
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textStyle = TextStyle(
      fontFamily: 'Baloo',
      color: Color(colorCode),
      fontSize: fontSize,
    );
    position = Offset.zero;
  }

  void setText(String text) {
    this.displayString = text;
  }

  Rect toRect() {
    return Rect.fromLTWH((game.viewport.width / 2) - (painter.width / 2),
        posY - (painter.height / 2), painter.width, painter.height);
  }

  @override
  void render(Canvas c) {
    painter.paint(c, position);
  }

  @override
  void update(double t) {
    if ((painter.text?.toString() ?? '') != displayString) {
      painter.text = TextSpan(
        text: displayString,
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
