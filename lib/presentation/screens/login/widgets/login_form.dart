import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbapipos/presentation/screens/login/widgets/login_input_type.dart';

import '../../../components/login_input.dart';
import '../bloc/login_bloc.dart';
import 'login_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required this.isVisible,
    required this.isLoading,
    required this.isEnable,
    this.emailError,
    this.passwordError,
  });

  final bool isVisible;
  final bool isLoading;
  final bool isEnable;

  final String? emailError;
  final String? passwordError;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late bool _isVisible;
  late bool _isLoading;
  late bool _isEnable;

  late String? _emailError;
  late String? _passwordError;

  late final FocusNode _emailFocus;
  late final FocusNode _passwordFocus;

  @override
  void initState() {
    _isVisible = widget.isVisible;
    _isLoading = widget.isLoading;
    _isEnable = widget.isEnable;
    _emailError = widget.emailError;
    _passwordError = widget.passwordError;

    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();

    super.initState();
  }

  @override
  void didUpdateWidget(covariant LoginForm oldWidget) {
    if (_isVisible != widget.isVisible) {
      _isVisible = widget.isVisible;
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

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LoginInputType(label: 'Email'),
        LoginInput(
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
        SizedBox(height: 32.0),
        LoginInputType(label: 'Senha'),
        LoginInput(
          hint: "Digite sua senha",
          isEnabled: _isEnable,
          isVisible: _isVisible,
          onChanged: (value) => _onPasswordChanged(context, value),
          onSubmitted: () => _onRequest(context),
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.visiblePassword,
          error: _passwordError,
          focus: _passwordFocus,
          suffixIcon: IconButton(
            onPressed: () => _onTogglePassordPressed(context),
            icon: Icon(!_isVisible ? Icons.visibility : Icons.visibility_off),
          ),
        ),
        SizedBox(height: 32.0),
        LoginButton(
          isEnable: _isEnable,
          isLoading: _isLoading,
          onPressed: () => _onRequest(context),
        ),
      ],
    );
  }

  void _onEmailChanged(BuildContext context, String value) {
    context.read<LoginBloc>().add(LoginSetEmail(value));
  }

  void _onPasswordChanged(BuildContext context, String value) {
    context.read<LoginBloc>().add(LoginSetPassword(value));
  }

  void _onRequest(BuildContext context) {
    _emailFocus.unfocus();
    _passwordFocus.unfocus();

    if (!_isEnable) {
      return;
    }

    context.read<LoginBloc>().add(const LoginRequest());
  }

  void _onTogglePassordPressed(BuildContext context) {
    if (!_isEnable) {
      return;
    }

    context.read<LoginBloc>().add(LoginTogglePassword());
  }
}
