import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/players_bloc.dart';
import 'players_card.dart';

class PlayersBody extends StatelessWidget {
  const PlayersBody({super.key, required this.state});

  final PlayersState state;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => _onRefreshed(context),
      child: ListView.separated(
        padding: const EdgeInsets.only(bottom: 96.0),
        itemBuilder: (context, index) {
          final player = state.players[index];

          return PlayersCard(player: player);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 8.0);
        },
        itemCount: state.players.length,
      ),
    );
  }

  Future<void> _onRefreshed(BuildContext context) async {
    context.read<PlayersBloc>().add(const PlayersLoad());
  }
}
