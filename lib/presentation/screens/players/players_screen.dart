import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/players_bloc.dart';
import 'widgets/players_content.dart';

class PlayersScreen extends StatelessWidget {
  const PlayersScreen({super.key, required this.playersBloc});

  final PlayersBloc playersBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => playersBloc..add(const PlayersLoad()),
      child: const PlayersContent(),
    );
  }
}
