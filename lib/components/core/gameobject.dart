import 'package:flutters/flutters-game.dart';

class GameObject {
  final FluttersGame game;
  double x;
  double y;
  double width;
  double height;
  double rotation;
  int colorCode;
  GameObject(this.game, this.x, this.y, this.width, this.height,
      [this.rotation = 0, this.colorCode = 0xff484848]);
}
