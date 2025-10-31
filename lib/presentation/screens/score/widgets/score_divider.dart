import 'package:flutter/material.dart';

class ScoreDivider extends StatelessWidget {
  const ScoreDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      '-',
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: 32.0,
      ),
    );
  }
}
