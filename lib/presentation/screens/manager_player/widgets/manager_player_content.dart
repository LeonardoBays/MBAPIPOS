import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/manager_player_bloc.dart';
import 'manager_player_body.dart';

class ManagerPlayerContent extends StatelessWidget {
  const ManagerPlayerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jogador'),),
      body: BlocBuilder<ManagerPlayerBloc, ManagerPlayerState>(
        builder: (context, state) {
          if (state is ManagerPlayerLoaded) {
            return ManagerPlayerBody(state: state);
          }

          if (state is ManagerPlayerLoadFail) {
            return Center(child: Text(state.message));
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
