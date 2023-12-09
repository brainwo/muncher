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
        '/': (context) => GameWidget(game: MyGame()),
        // '/': (context) => const Intro(),
        // '/menu': (context) => const Menu(),
      },
    );
  }
}
