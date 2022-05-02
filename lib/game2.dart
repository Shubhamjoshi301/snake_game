// import 'package:flame/game.dart';
// import 'package:flame/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flame/components.dart';

// class MyGame2 extends BaseGame with HasDraggableComponents {
//   String direction1 = "";
//   MyGame(String direction1){
//     this.direction1 = direction1;
//   }
//   SpriteComponent ninja = SpriteComponent();


//   bool running = true;
//   String direction = 'right';
//     SpriteAnimationComponent ninjarun = SpriteAnimationComponent();
//   Future<void> onLoad() async {
//     print("loading assets");
//     ninja
//       ..sprite = await loadSprite('ninja.png')
//       ..size = Vector2(100, 100)
//       ..x = 50
//       ..y = 300;

//     // add(ninja);
//     var ninjarunsprite = await images.load('ninjarun.png');
//     final spritesize = Vector2(100, 200);
//     SpriteAnimationData spriteData = SpriteAnimationData.sequenced(
//         amount: 10, stepTime: 0.2, textureSize: Vector2(152, 142));
//     ninjarun =
//         SpriteAnimationComponent.fromFrameData(ninjarunsprite, spriteData)
//           ..x = 50
//           ..y = 200
//           ..size = spritesize;
//       add(ninjarun);
//   }

//   @override
   
//   void onPanUpdate(DragUpdateDetails details){
    
//   }

//   @override
//   void update(double dt) {
//     // TODO: implement update
//     super.update(dt);
//     switch (direction) {
//       case 'right':
//         ninjarun.x += 1;
//         break;
//       case 'left':
//         ninjarun.x -= 1;
//         break;
//     }
//     if (ninjarun.x == 20) {
//       direction = 'right';
//     }
//     if (ninjarun.x == 500) {
//       direction = 'left';
//     }
//   }
// }