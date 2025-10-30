import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes.dart';
import '../../../../core/constants/enum/match_status.dart';
import '../../../../core/util/extensions/context_extension.dart';
import '../../../../data/models/match.dart';
import '../bloc/matches_bloc.dart';
import 'matches_score.dart';
import 'matches_team.dart';

class MatchesCard extends StatelessWidget {
  const MatchesCard({super.key, required this.match});

  final Match match;

  Color get _backgroundColor {
    return switch (match.status) {
      MatchStatus.onGoing => Colors.green.withValues(alpha: .1),
      MatchStatus.finished => Colors.grey.withValues(alpha: .1),
      MatchStatus.waiting => Colors.orange.withValues(alpha: .1),
    };
  }

  Color get _borderColor {
    return switch (match.status) {
      MatchStatus.onGoing => Colors.green.withValues(alpha: .2),
      MatchStatus.finished => Colors.grey.withValues(alpha: .2),
      MatchStatus.waiting => Colors.orange.withValues(alpha: .2),
    };
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onPressed(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: _backgroundColor,
            border: Border.all(color: _borderColor),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MatchesTeam(label: match.homeTeamName),

                  MatchesScore(
                    awayScore: match.awayScore,
                    homeScore: match.homeScore,
                  ),

                  MatchesTeam(
                    label: match.awayTeamName,
                    textAlign: TextAlign.end,
                  ),
                ],
              ),

              if (match.status == MatchStatus.waiting)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(match.statusLabel),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPressed(BuildContext context) {
    switch (match.status) {
      case MatchStatus.onGoing:
        _openScore(context);
      case MatchStatus.finished:
        _showSnackBar(context, "Partida finalizada!");
      case MatchStatus.waiting:
        _openMatchScreen(context);
    }
  }

  void _openMatchScreen(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    Navigator.of(context)
        .pushNamed(AppRoutes.managerMatch.route, arguments: match.id)
        .then((value) {
          if (value == true) {
            if (context.mounted) {
              context.read<MatchesBloc>().add(const MatchesLoad());
            }
          }
        });
  }

  void _openScore(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    Navigator.of(
      context,
    ).pushNamed(AppRoutes.score.route, arguments: match.id).then((value) {
      if (context.mounted) {
        context.read<MatchesBloc>().add(const MatchesLoad());
      }
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    context.showSuccessSnackBar(message, seconds: 5);
  }
}
