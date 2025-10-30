import 'package:flutter/material.dart';

class ScoreTeam extends StatelessWidget {
  const ScoreTeam({
    super.key,
    required this.name,
    required this.score,
    required this.increase,
    required this.decrease,
  });

  final String name;
  final int score;
  final Function() increase;
  final Function() decrease;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 18.0,
          ),
        ),

        Row(
          children: [
            IconButton(
              onPressed: increase,
              icon: const Icon(Icons.exposure_minus_1_outlined),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 12.0)),
            IconButton(
              onPressed: increase,
              icon: const Icon(Icons.plus_one_outlined),
            ),
          ],
        ),
      ],
    );
  }
}
