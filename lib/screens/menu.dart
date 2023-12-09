import 'package:flamejam/colors.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colorCyan,
      child: Center(
        child: MaterialButton(
          child: Text("Hello"),
          onPressed: () {
            print("Hello");
          },
        ),
      ),
    );
  }
}
