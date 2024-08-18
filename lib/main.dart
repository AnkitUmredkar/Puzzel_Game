import 'package:block_puzzel_game/Sreens/splashScreen.dart';
import 'package:flutter/material.dart';

import 'Sreens/board.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const Splashscreen(),
    );
  }
}
