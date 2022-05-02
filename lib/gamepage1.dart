// import 'package:flame/game.dart';
// import 'package:flame/gestures.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flame/components.dart';

// class MyGame1 extends BaseGame with PanDetector {
//   String direction1 = "right";
//   List<SpriteComponent> body = [];
//   int bodySize = 1;

//   // Size screenSize = Size(width, height)
//   MyGame1(String direction1) {
//     this.direction1 = direction1;
//     print(direction1);
//   }
//   void getDirection(String direction1) {
//     this.direction1 = direction1;
//   }

//   SpriteComponent ninja = SpriteComponent();
//   bool running = true;
//   // String direction = 'right';
//   // SpriteAnimationComponent ninjarun = SpriteAnimationComponent();
//   Future<void> onLoad() async {
//     print("loading assets");
//     print(size);

//     ninja
//       ..sprite = await loadSprite('whitecircle.png')
//       ..size = Vector2(size[0] * 0.07, size[0] * 0.07)
//       ..x = 40
//       ..y = 40;

//     body.add(ninja);

//     // addAll(body);
//   }

//   // void onPanUpdate(DragUpdateDetails details) {
//   //   // TODO: implement onPanUpdate
//   //   if(info.){

//   //   };
//   //   super.onPanUpdate(info);
//   // }
//   // void onDoubleTap() {
//   //   if (running) {
//   //     pauseEngine();
//   //   } else {
//   //     resumeEngine();
//   //   }
//   //   // TODO: implement onDoubleTap
//   //   super.onDoubleTap();
//   //   running = !running;
//   // }

//   List<SpriteComponent> growBody(List<SpriteComponent> body) {
//     body.add(ninja);
//     bodySize++;
//     return body;
//   }

//   @override
//   void update(double dt) async {
//     // TODO: implement update
//     // print("updating");
    
//     // print(direction1);
    
//       switch (direction1) {
//         case 'right':
//           // print("caseRight");
//           for(int i = 0 ; i<bodySize ; i++){
//             body[i].x += 3;
//           }
          
//           break;
//         case 'left':
//         for(int i = 0 ; i<bodySize ; i++){
//           body[i].x -= 3;
//         }
//           break;
//       }
//         for(int i = 0 ; i<bodySize ; i++){
//       if (body[i].x <= 0 && direction1 == 'left') {
//         body[i].x = size[0];
//         growBody(body);
//         // direction1 = 'right';
//       }
//         }
//           for(int i = 0 ; i<bodySize ; i++){
//       if (body[i].x >= size[0] - 10 && direction1 == 'right') {
//         // print(ninja.x);
//         growBody(body);
//         print(bodySize);
//         ninja.x = 10;
//         // direction1 = 'left';
//       }

//           }
    

//     for (int i = 0; i < bodySize; i++) {
//       int posx = 20;
//       int posy = 40;
//       ninja
//         ..sprite = await loadSprite('whitecircle.png')
//         ..size = Vector2(size[0] * 0.07, size[0] * 0.07)
//         ..x = 15
//         ..y = 40;
//       posx = posx - 15;
//       body.add(ninja);
//     }
//     addAll(body);
//     super.update(dt);
//   }
// }
