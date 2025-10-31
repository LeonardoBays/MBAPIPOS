import 'package:flutter/material.dart';

class ScoreTeamName extends StatelessWidget {
  const ScoreTeamName({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w600,
          fontSize: 18.0,
        ),
      ),
    );
  }
}
