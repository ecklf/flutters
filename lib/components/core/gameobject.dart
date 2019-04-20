import 'dart:ui';
import 'package:flutters/flutters-game.dart';

class GameObject {
  final FluttersGame game;
  List<GameObject> children = List<GameObject>();
  GameObject(this.game);

  void render(Canvas c) {
    children.forEach((child) => child.render(c));
  }

  void update(double t) {
    children.forEach((child) => child.update(t));
  }

  void addChild(GameObject child) {
    children.add(child);
  }

  void removeChild(GameObject child) {
    for (GameObject obj in children) {
      if (obj == child) {
        children.remove(obj);
      }
    }
  }
}
