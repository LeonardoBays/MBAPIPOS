import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbapipos/presentation/screens/login/bloc/login_bloc.dart';
import 'package:mbapipos/presentation/screens/login/widgets/login_content.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.loginBloc});

  final LoginBloc loginBloc;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late final LoginBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = widget.loginBloc;
    super.initState();
  }

  @override
  void dispose() {
    _loginBloc.add(const LoginReset());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.loginBloc,
      child: const LoginContent(),
    );
  }
}
