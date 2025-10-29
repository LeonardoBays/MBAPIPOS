import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/blank_content.dart';
import '../bloc/players_bloc.dart';
import 'players_body.dart';
import 'players_fab.dart';

class PlayersContent extends StatelessWidget {
  const PlayersContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jogadores')),
      body: BlocBuilder<PlayersBloc, PlayersState>(
        builder: (context, state) {
          if (state is PlayersLoaded) {
            return PlayersBody(state: state);
          }

          if (state is PlayersLoadedEmpty) {
            return BlankContent(
              message:
                  'Nenhum jogador cadastrado, adicione um jogador agora mesmo!',
              onRefreshed: () => _onRefreshed(context),
            );
          }

          if (state is PlayersLoadFail) {
            return Center(child: Text(state.message));
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: const PlayersFab(),
    );
  }

  void _onRefreshed(BuildContext context) {
    context.read<PlayersBloc>().add(const PlayersLoad());
  }
}
