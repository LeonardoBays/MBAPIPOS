import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/score_bloc.dart';
import 'score_actions.dart';
import 'score_divider.dart';
import 'score_points.dart';
import 'score_team_name.dart';

class ScoreBody extends StatelessWidget {
  const ScoreBody({super.key, required this.state});

  final ScoreState state;

  bool get _isSaving => state is! ScoreSaving;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ScoreTeamName(name: state.homeTeamName),
                ScoreTeamName(name: state.awayTeamName),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ScorePoints(score: state.homeScore),
                const ScoreDivider(),
                ScorePoints(score: state.awayScore),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ScoreActions(
                  decrease: _isSaving ? () => _decreaseHome(context) : null,
                  increase: _isSaving ? () => _increaseHome(context) : null,
                ),
                ScoreActions(
                  decrease: _isSaving ? () => _decreaseAway(context) : null,
                  increase: _isSaving ? () => _increaseAway(context) : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _decreaseHome(BuildContext context) {
    if (state is ScoreSaving) {
      return;
    }
    context.read<ScoreBloc>().add(const ScoreDecreaseHome());
  }

  void _decreaseAway(BuildContext context) {
    if (state is ScoreSaving) {
      return;
    }
    context.read<ScoreBloc>().add(const ScoreDecreaseAway());
  }

  void _increaseHome(BuildContext context) {
    if (state is ScoreSaving) {
      return;
    }
    context.read<ScoreBloc>().add(const ScoreIncreaseHome());
  }

  void _increaseAway(BuildContext context) {
    if (state is ScoreSaving) {
      return;
    }
    context.read<ScoreBloc>().add(const ScoreIncreaseAway());
  }
}
