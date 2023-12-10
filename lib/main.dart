// ignore_for_file: unused_import

import 'package:flame/game.dart';
import 'package:flamejam/game.dart';
import 'package:flamejam/screens/intro.dart';
import 'package:flamejam/screens/menu.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const Intro(),
        '/game': (context) => GameWidget(game: MyGame()),
      },
    );
  }
}
