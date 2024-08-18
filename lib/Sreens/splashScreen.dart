import 'dart:async';
import 'package:block_puzzel_game/Sreens/board.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Timer(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) =>  const GameBoard()));
    });
    return SafeArea(
        child: Scaffold(
          body: Center(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'T',
                    style: TextStyle(
                      letterSpacing: 1.8,
                      fontSize: width * 0.1,
                      color: Colors.tealAccent
                    )
                  ),
                  TextSpan(
                      text: 'E',
                      style: TextStyle(
                        letterSpacing: 1.8,
                        fontSize: width * 0.1,
                          color: Colors.yellowAccent
                      )
                  ),
                  TextSpan(
                      text: 'T',
                      style: TextStyle(
                        letterSpacing: 1.8,
                        fontSize: width * 0.1,
                          color: Colors.red
                      )
                  ),
                  TextSpan(
                      text: 'R',
                      style: TextStyle(
                        letterSpacing: 1.8,
                        fontSize: width * 0.1,
                          color: Colors.lightBlue
                      )
                  ),
                  TextSpan(
                      text: 'I',
                      style: TextStyle(
                        letterSpacing: 1.8,
                        fontSize: width * 0.1,
                          color: Colors.amber
                      )
                  ),
                  TextSpan(
                      text: 'S',
                      style: TextStyle(
                        letterSpacing: 1.8,
                        fontSize: width * 0.1,
                          color: Colors.purple
                      )
                  ),
                ]
              )
            ),
          )
    ));
  }
}
