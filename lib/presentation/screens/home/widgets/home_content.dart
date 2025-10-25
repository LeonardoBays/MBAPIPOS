import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbapipos/core/util/extensions/context_extension.dart';
import 'package:mbapipos/presentation/screens/home/widgets/home_body.dart';

import '../../../components/dialogs/confirmation_dialog.dart';
import '../bloc/home_bloc.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            onPressed: () => _showDialogConfirmacaoLogout(context),
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: _listener,
        builder: (context, state) {
          return HomeBody();
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
        return ConfirmationDialog(
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
