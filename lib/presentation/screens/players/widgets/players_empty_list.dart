import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/players_bloc.dart';

class PlayersEmptyList extends StatelessWidget {
  const PlayersEmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: const Text('Lista vazia'),
      onRefresh: () async => _onRefreshed(context),
    );
  }

  Future<void> _onRefreshed(BuildContext context) async {
    context.read<PlayersBloc>().add(const PlayersLoad());
  }
}
