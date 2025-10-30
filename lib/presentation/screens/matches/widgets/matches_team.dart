import 'package:flutter/material.dart';

class MatchesTeam extends StatelessWidget {
  const MatchesTeam({super.key, required this.label, this.textAlign = TextAlign.start});

  final String label;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        label,
        textAlign: textAlign,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      ),
    );
  }
}
