import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes.dart';
import '../../../../data/models/player.dart';
import '../bloc/players_bloc.dart';

class PlayersCard extends StatelessWidget {
  const PlayersCard({super.key, required this.player});

  final Player player;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onPressed(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                player.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onPressed(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    Navigator.of(context)
        .pushNamed(AppRoutes.managerPlayer.route, arguments: player.id)
        .then((value) {
          if (value == true) {
            if (context.mounted) {
              context.read<PlayersBloc>().add(const PlayersLoad());
            }
          }
        });
  }
}
