import 'package:flamejam/const.dart';
import 'package:flutter/material.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  bool visible = false;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).whenComplete(
      () => Navigator.pushReplacementNamed(context, '/game'),
    );
    Future.delayed(const Duration(milliseconds: 100)).whenComplete(
      () => setState(() {
        visible = true;
      }),
    );
    Future.delayed(const Duration(milliseconds: 2500)).whenComplete(
      () => setState(() {
        visible = false;
      }),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: AnimatedOpacity(
        opacity: visible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Proudly presented to you by:',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Carme',
                  color: Colors.white,
                ),
              ),
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 8.0, 0, 0),
                    child: Text(
                      'Brian Wo',
                      style: TextStyle(
                        fontSize: 56,
                        fontFamily: 'TitanOne',
                        color: colorCyan,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 12.0, 8.0, 0),
                    child: Text(
                      'Brian Wo',
                      style: TextStyle(
                        fontSize: 56,
                        fontFamily: 'TitanOne',
                        color: colorYellow,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(4.0, 0.0, 8.0, 0),
                    child: Text(
                      'Brian Wo',
                      style: TextStyle(
                        fontSize: 56,
                        fontFamily: 'TitanOne',
                        color: colorMagenta,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 5.0, 8.0, 0),
                    child: Text(
                      'Brian Wo',
                      style: TextStyle(
                        fontSize: 56,
                        fontFamily: 'TitanOne',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
