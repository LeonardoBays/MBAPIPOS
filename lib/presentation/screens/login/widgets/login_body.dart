import 'package:flutter/material.dart';

import '../bloc/login_bloc.dart';
import 'login_form.dart';
import 'login_register.dart';
import 'login_title.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key, required this.state});

  final LoginState state;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LoginTitle(),
            const SizedBox(height: 48.0),
            LoginForm(
              emailError: state.emailError,
              passwordError: state.passwordError,
              isVisible: state.isPasswordVisible,
              isLoading: state is LoginLoading,
              isEnable: state is! LoginLoading,
            ),
            const SizedBox(height: 18.0),
            const LoginRegister(),
          ],
        ),
      ),
    );
  }
}
