import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/dialogs/confirmation_dialog.dart';
import '../bloc/manager_player_bloc.dart';

class ManagerPlayerDeleteBtn extends StatelessWidget {
  const ManagerPlayerDeleteBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManagerPlayerBloc, ManagerPlayerState>(
      builder: (context, state) {
        if (state.hasPlayer) {
          return IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _onPressed(context, state is! ManagerPlayerSaving);
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
          title: 'Remover jogador',
          content: 'Tem certeza que deseja remover o jogador?',
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
    context.read<ManagerPlayerBloc>().add(const ManagerPlayerDelete());
  }
}
