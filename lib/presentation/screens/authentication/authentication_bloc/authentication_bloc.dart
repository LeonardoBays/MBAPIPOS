import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/resources/handler_exception.dart';
import '../../../../domain/controller/authentication_controller.dart';
import '../../../../domain/controller/preferences_controller.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(
    this._authenticationController,
    this._preferencesController,
  ) : super(const AuthenticationState.authenticating()) {
    on<AuthenticationLoad>(_onAuthenticationLoad);
    on<AuthenticationStatusChange>(_onAuthenticationStatusChange);
  }

  final AuthenticationController _authenticationController;
  final PreferencesController _preferencesController;

  FutureOr<void> _onAuthenticationLoad(
    AuthenticationLoad event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      throw UnauthenticatedException();
      emit(const AuthenticationState.authenticated());
    } catch (e) {
      emit(const AuthenticationState.unauthenticated());
    }
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
