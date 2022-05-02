import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'gamepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Snake',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int score = 0;
  bool isDead = false;
  var game = MyGame();
  Widget getScore() {
    setState(() {
      score = MyGame.score;
    });
    return Align(
      alignment: Alignment.topCenter,
      child: Text(
        "Score: " + score.toString(),
        style: TextStyle(
            fontFamily: "Pokemon",
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
            color: Colors.white),
      ),
    );
  }

  void restart() {
    game.restart();
    setState(() {
      score = MyGame.score;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          // height: 500,
          // width: 300,
          // margin: EdgeInsets.symmetric(horizontal: 50,vertical: 150),
          child: GestureDetector(
            onDoubleTap: () {
              setState(() {});
              game.onDoubleTap();
            },
            onHorizontalDragUpdate: (details) {
              setState(() {
                score = MyGame.score;
              });
              isDead = MyGame.isDead;
              if (isDead) {
                showDialog(
                    // barrierDismissible: true,

                    context: context,
                    builder: (_) => Container(
                          // color: Colors.indigo[900],
                          child: AlertDialog(
                            backgroundColor: Colors.grey[600],
                            title: Text(
                              "Lost!!",
                              style: TextStyle(
                                  fontSize: 40,
                                  fontFamily: "Pokemon",
                                  fontWeight: FontWeight.bold),
                            ),
                            content: Text(
                              "Do you want to play again?",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "Pokemon",
                                  fontWeight: FontWeight.bold),
                            ),
                            actions: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.grey[500]),
                                  onPressed: () {
                                    restart();
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "YES!",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: "Pokemon",
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red[900]),
                                  )),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.grey[500]),
                                  onPressed: () => {SystemNavigator.pop()},
                                  child: Text(
                                    "NO!",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: "Pokemon",
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red[900]),
                                  )),
                            ],
                          ),
                        ));
              }
              if (details.delta.dx > 0) {
                // print("right");
                // swipeDirection = 'right';
                if (game.direction1 != 'left') {
                  game.direction1 = 'right';
                }
              } else if (details.delta.dx < 0) {
                // print("left");
                // swipeDirection = 'left';
                if (game.direction1 != 'right') {
                  game.direction1 = 'left';
                }
              }
            },
            onVerticalDragUpdate: (details) {
              setState(() {
                score = MyGame.score;
              });

              isDead = MyGame.isDead;
              if (isDead) {
                showDialog(
                  // barrierDismissible: true,

                  context: context,
                  builder: (_) => Container(
                    // color: Colors.indigo[900],
                    child: AlertDialog(
                      backgroundColor: Colors.grey[600],
                      title: Text(
                        "Lost!!",
                        style: TextStyle(
                            fontSize: 40,
                            fontFamily: "Pokemon",
                            fontWeight: FontWeight.bold),
                      ),
                      content: Text(
                        "Do you want to play again?",
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: "Pokemon",
                            fontWeight: FontWeight.bold),
                      ),
                      actions: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.grey[500]),
                            onPressed: () {
                              restart();
                              Navigator.pop(context);
                            },
                            child: Text(
                              "YES!",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: "Pokemon",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red[900]),
                            )),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.grey[500]),
                            onPressed: () => {SystemNavigator.pop()},
                            child: Text(
                              "NO!",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: "Pokemon",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red[900]),
                            )),
                      ],
                    ),
                  ),
                );
              }

              if (details.delta.dy < 0) {
                // swipeDirection = 'up';
                if (game.direction1 != 'down') {
                  game.direction1 = 'up';
                }

                // print("up");
              } else if (details.delta.dy > 0) {
                // swipeDirection = 'down';
                if (game.direction1 != 'up') {
                  game.direction1 = 'down';
                }

                // print("down");
              }
            },
            child: SizedBox.expand(
              child: Stack(
                children: [
                  GameWidget(
                    game: game,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: getScore(),
                    // ),
                  ),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      margin: const EdgeInsets.only(bottom: 20.0, right: 20.0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.restart_alt,
                            color: Colors.white,
                            size: 50,
                          ),
                          onPressed: () => {restart()},
                          // child: Text("Restart"),
                        ),
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: game.running
                          ? Text("")
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 120),
                                Text('Double tap to',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color:
                                            Color.fromRGBO(255, 255, 255, 0.6),
                                        fontStyle: FontStyle.italic,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                Text('start the game!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color:
                                            Color.fromRGBO(255, 255, 255, 0.6),
                                        fontStyle: FontStyle.italic,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
