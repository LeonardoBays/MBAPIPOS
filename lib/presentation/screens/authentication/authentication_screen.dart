import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../config/routes.dart';
import '../home/bloc/home_bloc.dart';
import '../home/home_screen.dart';
import '../login/bloc/login_bloc.dart';
import '../login/login_screen.dart';
import 'bloc/authentication_bloc.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({
    super.key,
    required this.authenticationBloc,
    required this.loginBloc,
    required this.homeBloc,
  });

  final AuthenticationBloc authenticationBloc;
  final LoginBloc loginBloc;
  final HomeBloc homeBloc;

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  late final AuthenticationBloc _authenticationBloc;
  late final LoginBloc _loginBloc;
  late final HomeBloc _homeBloc;

  @override
  void initState() {
    _authenticationBloc = widget.authenticationBloc;
    _loginBloc = widget.loginBloc;
    _homeBloc = widget.homeBloc;

    _authenticationListener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: _listener,
      bloc: _authenticationBloc,
      builder: (BuildContext context, AuthenticationState state) {
        return switch (state.authStatus) {
          AuthStatus.unauthenticated => LoginScreen(loginBloc: _loginBloc),
          AuthStatus.authenticating => const Center(
            child: CircularProgressIndicator(),
          ),
          AuthStatus.authenticated => HomeScreen(homeBloc: _homeBloc),
        };
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

  void _authenticationListener() {
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      final Session? session = data.session;

      switch (event) {
        case AuthChangeEvent.initialSession:
        case AuthChangeEvent.signedIn:
          if (session != null) {
            _authenticationBloc.add(
              const AuthenticationStatusChange(AuthStatus.authenticated),
            );
          } else {
            _authenticationBloc.add(
              const AuthenticationStatusChange(AuthStatus.unauthenticated),
            );
          }
        case AuthChangeEvent.signedOut:
          _authenticationBloc.add(
            const AuthenticationStatusChange(AuthStatus.unauthenticated),
          );
        case _:
          break;
      }
    });
  }
}
