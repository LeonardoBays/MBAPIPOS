import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/extensions/context_extension.dart';
import '../bloc/login_bloc.dart';
import 'login_body.dart';

class LoginContent extends StatelessWidget {
  const LoginContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: _listener,
          builder: (context, state) {
            return LoginBody(state: state);
          },
        ),
      ),
    );
  }

  void _listener(BuildContext context, LoginState state) {
    if (state is LoginWarning) {
      _showSnackBar(context, state.message);
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    context.showFailSnackBar(message);
  }
}
