import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes.dart';
import '../bloc/players_bloc.dart';

class PlayersFab extends StatelessWidget {
  const PlayersFab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayersBloc, PlayersState>(
      builder: (context, state) {
        if (state is PlayersLoading || state is PlayersInitial) {
          return const SizedBox();
        }

        return FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () => _onPressed(context),
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        );
      },
    );
  }

  void _onPressed(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.managerPlayer.route).then((
      value,
    ) {
      if (value == true) {
        if (context.mounted) {
          context.read<PlayersBloc>().add(const PlayersLoad());
        }
      }
    });
  }
}
