import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/extensions/context_extension.dart';
import '../../../components/dialogs/warning_dialog.dart';
import '../bloc/manager_match_bloc.dart';
import 'manager_match_body.dart';
import 'manager_match_delete_btn.dart';

class ManagerMatchContent extends StatelessWidget {
  const ManagerMatchContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Partida'),
        actions: [const ManagerMatchDeleteBtn()],
      ),
      body: BlocConsumer<ManagerMatchBloc, ManagerMatchState>(
        listener: _listener,
        builder: (context, state) {
          if (state is ManagerMatchLoaded ||
              state is ManagerMatchSaving ||
              state is ManagerMatchWarning) {
            return ManagerMatchBody(state: state);
          }

          if (state is ManagerMatchLoadFail) {
            return Center(child: Text(state.message));
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void _listener(BuildContext context, ManagerMatchState state) {
    if (state is ManagerMatchWarning) {
      _showDialogWarning(context, state.message);
    }

    if (state is ManagerMatchSuccess) {
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
