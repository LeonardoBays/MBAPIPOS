import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(
  ) : super(const AuthenticationState.authenticating()) {
    on<AuthenticationStatusChange>(_onAuthenticationStatusChange);
  }

  FutureOr<void> _onAuthenticationStatusChange(
    AuthenticationStatusChange event,
    Emitter<AuthenticationState> emit,
  ) async {
    final state = switch (event.authStatus) {
      AuthStatus.unauthenticated => const AuthenticationState.unauthenticated(),
      AuthStatus.authenticating => const AuthenticationState.authenticating(),
      AuthStatus.authenticated => const AuthenticationState.authenticated(),
    };

    emit(state);
  }
}
