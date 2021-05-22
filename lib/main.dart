import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutters/flutters-game.dart';

void main() async {
  Util flameUtil = Util();
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await Flame.util.setPortrait();
    await Flame.util.fullScreen();
  }

  Flame.images.loadAll(<String>[
    'bird-0.png',
    'bird-1.png',
    'bird-0-left.png',
    'bird-1-left.png',
    'cloud-1.png',
    'cloud-2.png',
    'cloud-3.png',
  ]);

  final screenDimensions = await Flame.util.initialDimensions();
  FluttersGame game = FluttersGame(screenDimensions);
  TapGestureRecognizer tapSink = TapGestureRecognizer();
  tapSink.onTapDown = game.onTapDown;
  tapSink.onTapUp = game.onTapUp;
  RawKeyboard.instance.addListener((RawKeyEvent rawKeyEvent) {
    final space = ' ';
    if (rawKeyEvent.character == space) {
      game.onTapDown(TapDownDetails());
    }
  });

  runApp(game.widget);
  flameUtil.addGestureRecognizer(tapSink);
}
