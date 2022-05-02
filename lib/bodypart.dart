
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:snakegame/gamepage.dart';
import 'package:snakegame/head.dart';

class BodyPart extends SpriteComponent with Hitbox, Collidable {

  BodyPart({Vector2? position,Vector2? size})
      : super(position: position, size: size) {
        // debugMode = true;
        addShape(HitboxRectangle());
      }
  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    if(other is Head){
      MyGame.isDead = true;
    }

    
  }
}
