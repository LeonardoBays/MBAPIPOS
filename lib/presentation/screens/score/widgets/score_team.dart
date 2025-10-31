// import 'package:flutter/material.dart';
//
// import 'score_actions.dart';
// import 'score_points.dart';
// import 'score_team_name.dart';
//
// class ScoreTeam extends StatelessWidget {
//   const ScoreTeam({
//     super.key,
//     required this.name,
//     required this.score,
//     required this.increase,
//     required this.decrease,
//   });
//
//   final String name;
//   final int score;
//   final Function()? increase;
//   final Function()? decrease;
//
//   @override
//   Widget build(BuildContext context) {
//     return Flexible(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           ScoreTeamName(name: name),
//
//           ScorePoints(score: score),
//
//           ScoreActions(increase: increase, decrease: decrease),
//         ],
//       ),
//     );
//   }
// }
