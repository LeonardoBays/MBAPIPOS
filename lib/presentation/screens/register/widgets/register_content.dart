import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/extensions/context_extension.dart';
import '../bloc/register_bloc.dart';
import 'register_body.dart';

class RegisterContent extends StatelessWidget {
  const RegisterContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<RegisterBloc, RegisterState>(
          listener: _listener,
          builder: (context, state) {
            return RegisterBody(state: state);
          },
        ),
      ),
    );
  }

  void _listener(BuildContext context, RegisterState state) {
    if (state is RegisterWarning) {
      _showErrorSnackBar(context, state.message);
    }
    if (state is RegisterSuccess) {
      _showSuccessSnackBar(context);
      Navigator.of(context).pop();
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    context.showFailSnackBar(message);
  }

  void _showSuccessSnackBar(BuildContext context) {
    context.showSuccessSnackBar("Usuário cadastrado com sucesso!");
  }
}
