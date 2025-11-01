import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes.dart';
import '../bloc/matches_bloc.dart';

class MatchesFab extends StatelessWidget {
  const MatchesFab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchesBloc, MatchesState>(
      builder: (context, state) {
        if (state is MatchesLoading || state is MatchesInitial) {
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
    ScaffoldMessenger.of(context).clearSnackBars();
    Navigator.of(context).pushNamed(AppRoutes.managerMatch.route).then((value) {
      if (context.mounted) {
        if (value == true) {
          context.read<MatchesBloc>().add(const MatchesLoad());
        }
      }
    });
  }
}
