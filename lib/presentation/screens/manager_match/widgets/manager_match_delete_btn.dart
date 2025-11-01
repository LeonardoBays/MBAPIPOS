import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/dialogs/confirmation_dialog.dart';
import '../bloc/manager_match_bloc.dart';

class ManagerMatchDeleteBtn extends StatelessWidget {
  const ManagerMatchDeleteBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManagerMatchBloc, ManagerMatchState>(
      builder: (context, state) {
        if (state.hasPlayer) {
          return IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _onPressed(context, state is! ManagerMatchSaving);
            },
          );
        }

        return Container();
      },
    );
  }

  void _onPressed(BuildContext context, bool isEnable) {
    if (!isEnable) {
      return;
    }

    showDialog(
      context: context,
      builder: (_) {
        return const ConfirmationDialog(
          title: 'Remover partida',
          content: 'Tem certeza que deseja remover a partida?',
        );
      },
    ).then((value) {
      if (value == true) {
        if (context.mounted) {
          _onDeleted(context);
        }
      }
    });
  }

  void _onDeleted(BuildContext context) {
    context.read<ManagerMatchBloc>().add(const ManagerMatchDelete());
  }
}
