import 'package:flutter/material.dart';

class MatchesScore extends StatelessWidget {
  const MatchesScore({
    super.key,
    required this.homeScore,
    required this.awayScore,
  });

  final int homeScore;
  final int awayScore;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: RichText(
          text: TextSpan(
            text: "$homeScore",
            children: [
              const TextSpan(text: " - "),
              TextSpan(text: "$awayScore"),
            ],
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 26.0,
            ),
          ),
        ),
      ),
    );
  }
}
