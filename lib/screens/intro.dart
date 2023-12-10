import 'package:flamejam/const.dart';
import 'package:flutter/material.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3)).whenComplete(
      () => Navigator.pushReplacementNamed(context, '/game'),
    );

    return const Material(
      color: Colors.black,
      child: Center(
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
    );
  }
}
