// import 'dart:io';
import 'package:universal_io/io.dart';
import 'dart:math';

import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:snakegame/bodypart.dart';
import 'package:snakegame/food.dart';
import 'package:snakegame/head.dart';

class MyGame extends BaseGame with  HasCollidables {
  String direction1 = "down";
  static bool hasCollided = false;
  static int score = 0;
  int speed = 0;
  double bodyPartsize = 0;
  static bool isDead = false;
  static List<SpriteComponent> body = [];
  static List<SpriteComponent> foods = [];
  Head head = Head();
  double screenHeight = 0;
  double screenWidth = 0;
  double screenTop = 10;
  double screenLeft = 0;
  static int bodySize = 5;
  var timer = 0;
  static var foodCount = 0;
  bool running = false;

  void restart() {
    resumeEngine();
    // destroy(body);
    for (int i = 0; i < bodySize; i++) {
      body[i].shouldRemove = true;
    }
    for (int i = 0; i < foods.length; i++) {
      foods[i].shouldRemove = true;
    }

    direction1 = "down";
    hasCollided = false;
    score = 0;
    isDead = false;
    body = [];
    head = Head();
    bodySize = 5;
    timer = 0;
    foodCount = 0;
    running = false;
    speed = 0;
    if(!running)
    // pauseEngine();
    onLoad();
  }

  ////////////////////////// On load method to load all initial components/////////////////////////////////

  Future<void> onLoad() async {
    print("loading assets");
    screenHeight = size[1] - 5;
    speed = 0;
    screenWidth = size[0] - 5;
    bodyPartsize = min((screenWidth) * 0.07, (screenHeight) * 0.07) - 10;
    backgroundColor().green;
    SpriteComponent bg = SpriteComponent();
    SpriteComponent neck1 = SpriteComponent();
    SpriteComponent neck2 = SpriteComponent();
    bg
      ..sprite = await loadSprite('background.jpeg')
      ..size = Vector2(size[0], size[1])
      ..x = 0
      ..y = 0;
    add(bg);
    // print(size);
    body.add(head);
    body.add(neck1);
    body.add(neck2);
    for (int i = 3; i < bodySize; i++) {
      BodyPart bodyPart = BodyPart();
      body.add(bodyPart);
    }

    body[0]
      ..sprite = await loadSprite('square.png')
      ..size = Vector2(bodyPartsize,
          bodyPartsize)
      ..x = screenWidth/2
      ..y = screenHeight/2
      ..anchor = Anchor.center;
    body[1]
      ..sprite = await loadSprite('square1.png')
      ..size = Vector2(bodyPartsize,
          bodyPartsize)
  ..x = screenWidth/2
      ..y = screenHeight/2 - bodyPartsize
      ..anchor = Anchor.center;
    body[2]
      ..sprite = await loadSprite('square1.png')
      ..size = Vector2(bodyPartsize,
          bodyPartsize)
     ..x = screenWidth/2
      ..y = screenHeight/2 - 2*bodyPartsize
      ..anchor = Anchor.center;
    for (int i = 3; i < bodySize; i++) {
      body[i]
        ..sprite = await loadSprite('square1.png')
        ..size = Vector2(bodyPartsize,
            bodyPartsize)
     ..x = screenWidth/2
      ..y = screenHeight/2 - i *bodyPartsize
        ..anchor = Anchor.center;
    }
    addAll(body);
    isDead = false;
    running = false;
   
  }

  // void restart() {
  //   pauseEngine();
  // }

  ////////////////// On double tap stop game engine ///////////////////////////////////////////
  void onDoubleTap() async {
    if (running) {
      pauseEngine();
    } else {
      resumeEngine();
    }
    // super.onDoubleTap();
    running = !running;
  }

  Future<Offset> getNextPosition(Offset position) async {
    Offset nextPosition = Offset(position.dx + 2, position.dy);

    if (direction1 == "right") {
      nextPosition = Offset(position.dx + bodyPartsize, position.dy);
      sleep(Duration(milliseconds: 100 - speed));
      return nextPosition;
    } else if (direction1 == "left") {
      nextPosition = Offset(position.dx - bodyPartsize, position.dy);
      sleep(Duration(milliseconds: 100 - speed));
      return nextPosition;
    } else if (direction1 == 'up') {
      nextPosition = Offset(position.dx, position.dy - bodyPartsize);
      sleep(Duration(milliseconds: 100 - speed));
      return nextPosition;
    } else if (direction1 == 'down') {
      nextPosition = Offset(position.dx, position.dy + bodyPartsize);
      sleep(Duration(milliseconds: 100 - speed));
      return nextPosition;
    }

    return nextPosition;
  }

  ///////////////////////////// Overridden Update Method ///////////////////////////////////////
  @override
  void update(double dt) async {
    timer += 1;
    if(!running ){
      pauseEngine();
    }
    /////////////////////////////// Movement of snake //////////////////////////////////////////

    for (int i = body.length - 1; i > 0; i--) {
      body[i].x = body[i - 1].x;
      body[i].y = body[i - 1].y;
    }
    Offset position;
    Offset position0;
    position0 = Offset(body[0].x, body[0].y);
    position = await getNextPosition(position0);
    body[0].x = position.dx;
    body[0].y = position.dy;

    ////////////////////////////// If snake gets out of boundry ////////////////////////////////////
    if (body[0].x <= screenLeft && direction1 == 'left') {
      body[0].x = screenWidth;
    } else if (body[0].x >= screenWidth && direction1 == 'right') {
      body[0].x = screenLeft;
    } else if (body[0].y >= screenHeight && direction1 == 'down') {
      body[0].y = screenTop;
    } else if (body[0].y <= screenTop && direction1 == 'up') {
      body[0].y = screenHeight;
    }

    ///////////////////////////////// render food on screen///////////////////////////////////

    if (timer % 65 == 0 && foods.length < 4) {
      var rand = new Random();
      Food food = Food();
      food
        ..sprite = await loadSprite('whitecircle.png')
        ..size = Vector2(min(screenWidth * 0.07, screenHeight * 0.07),
            min(screenWidth * 0.07, screenHeight * 0.07))
        ..x = 20 + rand.nextDouble() * ( (screenWidth - 40) - 40)
        ..y = 40 + rand.nextDouble() * ((screenHeight - 40) - 40)
        ..anchor = Anchor.center;
      foods.add(food);
      add(food);
    }

    ////////////////////////// If snake eats food increase body size/////////////////////////////////

    if (hasCollided) {
      BodyPart bodyPart = BodyPart();
      body.add(bodyPart);
      bodySize++;
      body[body.length - 1]
        ..sprite = await loadSprite('square1.png')
        ..size = Vector2(bodyPartsize,
            bodyPartsize)
        ..x = -50
        ..y = -50
        ..anchor = Anchor.center;
      score += 1;
      if (speed < 30 && score % 3 == 0) {
        speed += 20;
      } else if (score % 5 == 0 && speed <= 90) {
        speed += 10;
      }

      add(body[body.length - 1]);
      foods.removeLast();
      hasCollided = false;
    }

    if (isDead && running) {
      pauseEngine();
      running = false;
    }

    super.update(dt);
  }
}
