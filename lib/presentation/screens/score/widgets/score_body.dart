import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/score_bloc.dart';
import 'score_team.dart';

class ScoreBody extends StatelessWidget {
  const ScoreBody({super.key, required this.state});

  final ScoreState state;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ScoreTeam(
              name: state.homeTeamName,
              score: state.homeScore,
              decrease: () => _decreaseHome(context),
              increase: () => _increaseHome(context),
            ),

            // Text('${state.homeScore} - ${state.awayScore}'),
            Text(
              ' - ',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 22.0,
              ),
            ),

            ScoreTeam(
              name: state.awayTeamName,
              score: state.awayScore,
              decrease: () => _decreaseAway(context),
              increase: () => _increaseAway(context),
            ),
          ],
        ),
      ),
    );
  }

  void _decreaseHome(BuildContext context) {
    context.read<ScoreBloc>().add(const ScoreDecreaseHome());
  }

  void _decreaseAway(BuildContext context) {
    context.read<ScoreBloc>().add(const ScoreDecreaseAway());
  }

  void _increaseHome(BuildContext context) {
    context.read<ScoreBloc>().add(const ScoreIncreaseHome());
  }

  void _increaseAway(BuildContext context) {
    context.read<ScoreBloc>().add(const ScoreIncreaseAway());
  }
}
