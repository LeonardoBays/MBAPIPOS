import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/blank_content.dart';
import '../bloc/matches_bloc.dart';
import 'matches_body.dart';
import 'matches_fab.dart';

class MatchesContent extends StatelessWidget {
  const MatchesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Partidas agendadas')),
      body: BlocBuilder<MatchesBloc, MatchesState>(
        builder: (context, state) {
          if (state is MatchesLoaded) {
            return MatchesBody(state: state);
          }

          if (state is MatchesLoadedEmpty) {
            return BlankContent(
              message: "Nenhuma partida encontrada, cadastre uma agora mesmo!",
              onRefreshed: () => _onRefreshed(context),
            );
          }

          if (state is MatchesLoadFail) {
            return BlankContent(
              message: state.message,
              onRefreshed: () => _onRefreshed(context),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: const MatchesFab(),
    );
  }

  void _onRefreshed(BuildContext context) {
    context.read<MatchesBloc>().add(const MatchesLoad());
  }
}
