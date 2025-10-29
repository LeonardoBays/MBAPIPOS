import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/players_bloc.dart';
import 'players_body.dart';

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

          if (state is PlayersLoadFail) {
            return Center(child: Text(state.message));
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
