import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/input.dart';
import '../bloc/register_bloc.dart';
import 'register_button.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    super.key,
    required this.isPasswordVisible,
    required this.isConfirmPasswordVisible,
    required this.isLoading,
    required this.isEnable,
    this.emailError,
    this.passwordError,
    this.confirmPasswordError,
  });

  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final bool isLoading;
  final bool isEnable;

  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late bool _isPasswordVisible;
  late bool _isConfirmPasswordVisible;
  late bool _isLoading;
  late bool _isEnable;

  late String? _emailError;
  late String? _passwordError;
  late String? _confirmPasswordError;

  late final FocusNode _emailFocus;
  late final FocusNode _passwordFocus;
  late final FocusNode _confirmPasswordFocus;

  @override
  void initState() {
    _isPasswordVisible = widget.isPasswordVisible;
    _isConfirmPasswordVisible = widget.isConfirmPasswordVisible;
    _isLoading = widget.isLoading;
    _isEnable = widget.isEnable;
    _emailError = widget.emailError;
    _passwordError = widget.passwordError;
    _confirmPasswordError = widget.confirmPasswordError;

    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
    _confirmPasswordFocus = FocusNode();

    super.initState();
  }

  @override
  void didUpdateWidget(covariant RegisterForm oldWidget) {
    if (_isPasswordVisible != widget.isPasswordVisible) {
      _isPasswordVisible = widget.isPasswordVisible;
    }
    if (_isConfirmPasswordVisible != widget.isConfirmPasswordVisible) {
      _isConfirmPasswordVisible = widget.isConfirmPasswordVisible;
    }
    if (_isLoading != widget.isLoading) {
      _isLoading = widget.isLoading;
    }
    if (_isEnable != widget.isEnable) {
      _isEnable = widget.isEnable;
    }
    if (_emailError != widget.emailError) {
      _emailError = widget.emailError;
    }
    if (_passwordError != widget.passwordError) {
      _passwordError = widget.passwordError;
    }
    if (_confirmPasswordError != widget.confirmPasswordError) {
      _confirmPasswordError = widget.confirmPasswordError;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Input(
          label: "Email",
          hint: "Digite seu email",
          isEnabled: _isEnable,
          isVisible: true,
          onChanged: (value) => _onEmailChanged(context, value),
          onSubmitted: () => _passwordFocus.requestFocus(),
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.emailAddress,
          error: _emailError,
          focus: _emailFocus,
        ),
        SizedBox(height: 16.0),
        Input(
          label: "Senha",
          hint: "Digite sua senha",
          isEnabled: _isEnable,
          isVisible: _isPasswordVisible,
          onChanged: (value) => _onPasswordChanged(context, value),
          onSubmitted: () => _confirmPasswordFocus.requestFocus(),
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.visiblePassword,
          error: _passwordError,
          focus: _passwordFocus,
          suffixIcon: IconButton(
            onPressed: () => _onTogglePassordPressed(context),
            icon: Icon(
              !_isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Input(
          label: "Confirmação de senha",
          hint: "Confirme sua senha",
          isEnabled: _isEnable,
          isVisible: _isConfirmPasswordVisible,
          onChanged: (value) => _onConfirmPasswordChanged(context, value),
          onSubmitted: () => _onRequest(context),
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.visiblePassword,
          error: _confirmPasswordError,
          focus: _confirmPasswordFocus,
          suffixIcon: IconButton(
            onPressed: () => _onToggleConfirmPassordPressed(context),
            icon: Icon(
              !_isConfirmPasswordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
            ),
          ),
        ),
        SizedBox(height: 32.0),
        RegisterButton(
          isEnable: _isEnable,
          isLoading: _isLoading,
          onPressed: () => _onRequest(context),
        ),
      ],
    );
  }

  void _onEmailChanged(BuildContext context, String value) {
    context.read<RegisterBloc>().add(RegisterSetEmail(value));
  }

  void _onPasswordChanged(BuildContext context, String value) {
    context.read<RegisterBloc>().add(RegisterSetPassword(value));
  }

  void _onConfirmPasswordChanged(BuildContext context, String value) {
    context.read<RegisterBloc>().add(RegisterSetConfirmPassword(value));
  }

  void _onRequest(BuildContext context) {
    _emailFocus.unfocus();
    _passwordFocus.unfocus();
    _confirmPasswordFocus.unfocus();

    if (!_isEnable) {
      return;
    }

    context.read<RegisterBloc>().add(const RegisterRequest());
  }

  void _onTogglePassordPressed(BuildContext context) {
    if (!_isEnable) {
      return;
    }

    context.read<RegisterBloc>().add(RegisterTogglePassword());
  }

  void _onToggleConfirmPassordPressed(BuildContext context) {
    if (!_isEnable) {
      return;
    }

    context.read<RegisterBloc>().add(RegisterToggleConfirmPassword());
  }
}
