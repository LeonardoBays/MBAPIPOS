import 'package:flutter/material.dart';

import '../bloc/register_bloc.dart';
import 'register_form.dart';

class RegisterBody extends StatelessWidget {
  const RegisterBody({super.key, required this.state});

  final RegisterState state;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      physics: const ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 48.0),
          RegisterForm(
            emailError: state.emailError,
            passwordError: state.passwordError,
            confirmPasswordError: state.passwordConfirmError,
            isPasswordVisible: state.isPasswordVisible,
            isConfirmPasswordVisible: state.isConfirmPasswordVisible,
            isLoading: state is RegisterLoading,
            isEnable: state is! RegisterLoading,
          ),
        ],
      ),
    );
  }
}
