import 'package:flutter/material.dart';

class ScorePoints extends StatelessWidget {
  const ScorePoints({super.key, required this.score});

  final int score;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Text(
          score.toString(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 64.0,
          ),
        ),
      ),
    );
  }
}
