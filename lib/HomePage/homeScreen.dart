import 'dart:async';
import 'package:flappy_bird/HomePage/Components/barrier.dart';
import 'package:flappy_bird/HomePage/Components/bird.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static double birdY = 0;
  static double birdHeight = 0.3;
  static double birdWidth = 0.3;
  double initpos = birdY;
  double height = 0;
  double time = 0;
  double gravity = -1.9;
  double velocity = 2.0;
  bool gameHasStarted = false;
  static double barrierXone = 1;
  double barrierXtwo = barrierXone + 1.5;
  int scoreCount = 0;
  int highScore = 0;
  int count = 0;

  static List<double> barrierXaxis = [2, 2 + 1.5];
  static double barrierWidth = 0.5;
  // List<List<double>> barrierHeight = [
  //   [0.6, 0.4],
  //   [0.4, 0.6],
  // ];

  static List<double> barrierYaxis = [1.1, -1.1];

  void gameStart() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 70), (timer) {
      height = gravity * time * time + velocity * time;
      setState(() {
        birdY = initpos - height;
        barrierXone += 0.02;
        barrierXtwo += 0.02;
        count++;
        if (count > 14) {
          scoreCount = scoreCount + 1;
          count = 0;
        }
      });
      setState(() {
        if (barrierXone < -2) {
          barrierXone += 3.5;
        } else {
          barrierXone -= 0.05;
        }
      });

      setState(() {
        if (barrierXtwo < -2) {
          barrierXtwo += 3.5;
        } else {
          barrierXtwo -= 0.05;
        }
      });

      if (birdIsDead()) {
        timer.cancel();
        gameHasStarted = false;
        _showDialogue();
      }
      time += 0.1;
    });
  }

  void _restartGame() {
    Navigator.pop(context);
    setState(() {
      birdY = 0;
      gameHasStarted = false;
      time = 0;
      initpos = birdY;
      if (scoreCount > highScore) {
        highScore = scoreCount;
      }
      scoreCount = 0;
      barrierXone = 1;
      barrierXtwo = barrierXone + 1.5;
    });
  }

  void _showDialogue() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.brown,
            title: const Center(
                child: Text(
              "G A M E  O V E R",
              style: TextStyle(color: Colors.white),
            )),
            actions: [
              GestureDetector(
                onTap: _restartGame,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    color: Colors.white,
                    child: const Text(
                      "PLAY AGAIN",
                      style: TextStyle(color: Colors.brown),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  void jump() {
    setState(() {
      time = 0;
      initpos = birdY;
    });
  }

  bool birdIsDead() {
    if (birdY < -1 || birdY > 1) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasStarted ? jump : gameStart,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 3,
                child: Container(
                  color: Colors.blue,
                  child: Center(
                      child: Stack(
                    children: [
                      Bird(
                          birdY: birdY,
                          birdHeight: birdHeight,
                          birdWidth: birdWidth),
                      Barrier(
                          barrierHeight: 0.7,
                          barrierXaxis: barrierXone,
                          barrierYaxis: barrierYaxis[0]),
                      Barrier(
                          barrierHeight: 0.7,
                          barrierXaxis: barrierXone,
                          barrierYaxis: barrierYaxis[1]),
                      Barrier(
                          barrierHeight: 0.9,
                          barrierXaxis: barrierXone+1.5,
                          barrierYaxis: barrierYaxis[0]),
                      Barrier(
                          barrierHeight: 0.5,
                          barrierXaxis: barrierXone+1.5,
                          barrierYaxis: barrierYaxis[1]),
                      Container(
                          alignment: const Alignment(0, -0.5),
                          child: Text(
                            gameHasStarted ? '' : 'T A P  T O  P L A Y',
                            style: const TextStyle(fontSize: 20),
                          )),
                    ],
                  )),
                )),
            Expanded(
                child: Container(
              color: Colors.brown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "SCORE",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "$scoreCount",
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      const Text(
                        "HIGHEST",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "$highScore",
                        style: const TextStyle(color: Colors.white, fontSize: 35),
                      )
                    ],
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
