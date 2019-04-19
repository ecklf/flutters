import 'dart:ui';

abstract class Renderable {
  void render(Canvas c) {}
  void update(double t) {}
}
