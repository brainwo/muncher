import 'package:flamejam/const.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colorCyan,
      child: Center(
        child: MaterialButton(
          child: const Text('Hello'),
          onPressed: () {
            if (kDebugMode) {
              print('Hello');
            }
          },
        ),
      ),
    );
  }
}
