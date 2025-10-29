import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/util/email_validator.dart';
import '../../../../domain/repositories/remote/supa_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._supaRepository) : super(const LoginInitial()) {
    on<LoginSetEmail>(_onLoginSetEmail);
    on<LoginSetPassword>(_onLoginSetPassword);
    on<LoginTogglePassword>(_onLoginTogglePassword);
    on<LoginRequest>(_onLoginRequest);
    on<LoginReset>(_onLoginReset);
  }

  final SupaRepository _supaRepository;

  FutureOr<void> _onLoginSetEmail(
    LoginSetEmail event,
    Emitter<LoginState> emit,
  ) {
    emit(
      LoginUpdated(
        email: event.value,
        emailError: null,
        isPasswordVisible: state.isPasswordVisible,
        password: state.password,
        passwordError: state.passwordError,
      ),
    );
  }

  FutureOr<void> _onLoginSetPassword(
    LoginSetPassword event,
    Emitter<LoginState> emit,
  ) {
    emit(
      LoginUpdated(
        email: state.email,
        emailError: state.emailError,
        isPasswordVisible: state.isPasswordVisible,
        password: event.value,
        passwordError: null,
      ),
    );
  }

  FutureOr<void> _onLoginTogglePassword(
    LoginTogglePassword event,
    Emitter<LoginState> emit,
  ) {
    emit(
      LoginUpdated(
        email: state.email,
        emailError: state.emailError,
        isPasswordVisible: !state.isPasswordVisible,
        password: state.password,
        passwordError: state.passwordError,
      ),
    );
  }

  FutureOr<void> _onLoginRequest(
    LoginRequest event,
    Emitter<LoginState> emit,
  ) async {
    try {
      if (state is LoginLoading) {
        return;
      }

      emit(
        LoginLoading(
          email: state.email,
          emailError: state.emailError,
          isPasswordVisible: state.isPasswordVisible,
          password: state.password,
          passwordError: state.passwordError,
        ),
      );

      String? errorEmail;
      String? errorPassword;

      errorEmail = EmailValidator.emailValidator(state.email);

      if (state.password.isEmpty) {
        errorPassword = "O campo da senha é obrigatorio.";
      }

      if (errorEmail != null || errorPassword != null) {
        emit(
          LoginUpdated(
            email: state.email,
            emailError: errorEmail,
            isPasswordVisible: state.isPasswordVisible,
            password: state.password,
            passwordError: errorPassword,
          ),
        );
        return;
      }

      await _supaRepository.auth(email: state.email, password: state.password);
    } on AuthException catch (error) {
      late String message;

      if (error.statusCode == '400') {
        message = 'Email ou senha incorretos. Tente novamente.';
      } else if (error.statusCode == '401') {
        message = 'Acesso negado. ${error.message}';
      } else {
        message = 'Ocorreu um erro de autenticação: ${error.message}';
      }

      emit(
        LoginWarning(
          message: message,
          email: state.email,
          emailError: state.emailError,
          isPasswordVisible: state.isPasswordVisible,
          password: state.password,
          passwordError: state.passwordError,
        ),
      );
    } catch (e) {
      emit(
        LoginWarning(
          message: "Deu pau: ${e.toString()}",
          email: state.email,
          emailError: state.emailError,
          isPasswordVisible: state.isPasswordVisible,
          password: state.password,
          passwordError: state.passwordError,
        ),
      );
    }
  }

  FutureOr<void> _onLoginReset(LoginReset event, Emitter<LoginState> emit) {
    emit(const LoginInitial());
  }
}
