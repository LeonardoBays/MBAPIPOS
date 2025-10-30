import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/extensions/context_extension.dart';
import '../../../components/dialogs/warning_dialog.dart';
import '../bloc/manager_player_bloc.dart';
import 'manager_player_body.dart';
import 'manager_player_delete_btn.dart';

class ManagerPlayerContent extends StatelessWidget {
  const ManagerPlayerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jogador'),
        actions: [const ManagerPlayerDeleteBtn()],
      ),
      body: BlocConsumer<ManagerPlayerBloc, ManagerPlayerState>(
        listener: _listener,
        builder: (context, state) {
          if (state is ManagerPlayerLoaded ||
              state is ManagerPlayerSaving ||
              state is ManagerPlayerWarning) {
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

  void _listener(BuildContext context, ManagerPlayerState state) {
    if (state is ManagerPlayerWarning) {
      _showDialogWarning(context, state.message);
    }

    if (state is ManagerPlayerSuccess) {
      _showSuccessSnackBar(context, state.message);
      Navigator.pop(context, true);
    }
  }

  void _showDialogWarning(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) {
        return WarningDialog(title: 'Atenção', message: message);
      },
    );
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    context.showSuccessSnackBar(message);
  }
}
