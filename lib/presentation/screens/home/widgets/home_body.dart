import 'package:flutter/material.dart';

import '../../../../config/routes.dart';
import 'home_button.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: HomeButton(
                  onPressed: () => _onMatchPressed(context),
                  label: "Partidas",
                  svgPath: 'assets/images/svg/match.svg',
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: HomeButton(
                  onPressed: () => _onPlayersPressed(context),
                  label: "Jogadores",
                  svgPath: 'assets/images/svg/players.svg',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Row(
            children: [
              Expanded(
                child: HomeButton(
                  onPressed: () => _onRankingPressed(context),
                  label: "Pontuação",
                  svgPath: 'assets/images/svg/ranking.svg',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onMatchPressed(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.matches.route);
  }

  void _onPlayersPressed(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.players.route);
  }

  void _onRankingPressed(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.ranking.route);
  }
}
