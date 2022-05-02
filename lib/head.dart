
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';


class Head extends SpriteComponent with Hitbox, Collidable {
  Head({Vector2? position,Vector2? size})
      : super(position: position, size: size) {
        // debugMode = true;
        addShape(HitboxRectangle());
      }
  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other ) {
    
    
    super.onCollision(intersectionPoints, other);

  }
}
