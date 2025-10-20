import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mbapipos/presentation/screens/login/login_screen.dart';

import '../../../config/routes.dart';
import 'authentication_bloc/authentication_bloc.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key, required this.authenticationBloc});

  final AuthenticationBloc authenticationBloc;

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  late final AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    _authenticationBloc = widget.authenticationBloc;

    _authenticationBloc.add(const AuthenticationLoad());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: _listener,
      bloc: _authenticationBloc,
      builder: (BuildContext context, AuthenticationState state) {
        return state.isAuthenticated ? Container() : const LoginScreen();
      },
    );
  }

  void _listener(BuildContext context, AuthenticationState state) async {
    if (!state.isAuthenticating) {
      FlutterNativeSplash.remove();
    }

    if (state.isUnauthenticated) {
      if (context.mounted) {
        Navigator.of(
          context,
        ).popUntil(ModalRoute.withName(AppRoutes.root.route));
      }
    }
  }
}
