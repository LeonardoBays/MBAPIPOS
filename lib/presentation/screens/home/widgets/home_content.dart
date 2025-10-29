import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/extensions/context_extension.dart';
import '../../../components/dialogs/confirmation_dialog.dart';
import '../bloc/home_bloc.dart';
import 'home_body.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () => _showDialogConfirmacaoLogout(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: _listener,
        builder: (context, state) {
          return const HomeBody();
        },
      ),
    );
  }

  void _onLogoutPressed(BuildContext context) {
    context.read<HomeBloc>().add(const HomeLogout());
  }

  void _showDialogConfirmacaoLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return const ConfirmationDialog(
          title: 'Logout',
          content: 'Tem certeza que deseja sair do aplicativo?',
        );
      },
    ).then((value) {
      if (value == true) {
        if (context.mounted) {
          _onLogoutPressed(context);
        }
      }
    });
  }

  void _listener(BuildContext context, HomeState state) {
    if (state is HomeWarning) {
      _showSnackBar(context, state.message);
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    context.showFailSnackBar(message);
  }
}
