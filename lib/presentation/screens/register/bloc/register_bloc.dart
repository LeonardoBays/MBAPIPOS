import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/util/email_validator.dart';
import '../../../../domain/repositories/remote/supa_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(this._supaRepository) : super(RegisterInitial()) {
    on<RegisterSetEmail>(_onRegisterSetEmail);
    on<RegisterSetPassword>(_onRegisterSetPassword);
    on<RegisterSetConfirmPassword>(_onRegisterSetConfirmPassword);
    on<RegisterTogglePassword>(_onRegisterTogglePassword);
    on<RegisterToggleConfirmPassword>(_onRegisterToggleConfirmPassword);
    on<RegisterRequest>(_onRegisterRequest);
  }

  final SupaRepository _supaRepository;

  FutureOr<void> _onRegisterSetEmail(
    RegisterSetEmail event,
    Emitter<RegisterState> emit,
  ) {
    emit(
      RegisterUpdated(
        email: event.value,
        emailError: null,
        password: state.password,
        passwordError: state.passwordError,
        passwordConfirm: state.passwordConfirm,
        passwordConfirmError: state.passwordConfirmError,
        isPasswordVisible: state.isPasswordVisible,
        isConfirmPasswordVisible: state.isConfirmPasswordVisible,
      ),
    );
  }

  FutureOr<void> _onRegisterSetPassword(
    RegisterSetPassword event,
    Emitter<RegisterState> emit,
  ) {
    emit(
      RegisterUpdated(
        email: state.email,
        emailError: state.emailError,
        password: event.value,
        passwordError: null,
        passwordConfirm: state.passwordConfirm,
        passwordConfirmError: state.passwordConfirmError,
        isPasswordVisible: state.isPasswordVisible,
        isConfirmPasswordVisible: state.isConfirmPasswordVisible,
      ),
    );
  }

  FutureOr<void> _onRegisterSetConfirmPassword(
    RegisterSetConfirmPassword event,
    Emitter<RegisterState> emit,
  ) {
    emit(
      RegisterUpdated(
        email: state.email,
        emailError: state.emailError,
        password: state.password,
        passwordError: state.passwordError,
        passwordConfirm: event.value,
        passwordConfirmError: null,
        isPasswordVisible: state.isPasswordVisible,
        isConfirmPasswordVisible: state.isConfirmPasswordVisible,
      ),
    );
  }

  FutureOr<void> _onRegisterTogglePassword(
    RegisterTogglePassword event,
    Emitter<RegisterState> emit,
  ) {
    emit(
      RegisterUpdated(
        email: state.email,
        emailError: state.emailError,
        password: state.password,
        passwordError: state.passwordError,
        passwordConfirm: state.passwordConfirm,
        passwordConfirmError: state.passwordConfirmError,
        isPasswordVisible: !state.isPasswordVisible,
        isConfirmPasswordVisible: state.isConfirmPasswordVisible,
      ),
    );
  }

  FutureOr<void> _onRegisterToggleConfirmPassword(
    RegisterToggleConfirmPassword event,
    Emitter<RegisterState> emit,
  ) {
    emit(
      RegisterUpdated(
        email: state.email,
        emailError: state.emailError,
        password: state.password,
        passwordError: state.passwordError,
        passwordConfirm: state.passwordConfirm,
        passwordConfirmError: state.passwordConfirmError,
        isPasswordVisible: state.isPasswordVisible,
        isConfirmPasswordVisible: !state.isConfirmPasswordVisible,
      ),
    );
  }

  FutureOr<void> _onRegisterRequest(
    RegisterRequest event,
    Emitter<RegisterState> emit,
  ) async {
    try {
      if (state is RegisterLoading) {
        return;
      }

      emit(
        RegisterLoading(
          email: state.email,
          emailError: state.emailError,
          password: state.password,
          passwordError: state.passwordError,
          passwordConfirm: state.passwordConfirm,
          passwordConfirmError: state.passwordConfirmError,
          isPasswordVisible: state.isPasswordVisible,
          isConfirmPasswordVisible: state.isConfirmPasswordVisible,
        ),
      );

      final email = state.email.trim();
      final password = state.password.trim();
      final confirmPassword = state.passwordConfirm.trim();

      String? errorEmail;
      String? errorPassword;
      String? errorConfirmPassword;

      errorEmail = EmailValidator.emailValidator(email);

      if (password.isEmpty) {
        errorPassword = "O campo da senha é obrigatorio.";
      }

      if (confirmPassword.isEmpty) {
        errorConfirmPassword = "O campo da confirmação de senha é obrigatorio.";
      }

      if (confirmPassword != password) {
        errorConfirmPassword =
            "A confirmação da senha não coincide com a senha informada.";
      }

      if (errorEmail != null ||
          errorPassword != null ||
          errorConfirmPassword != null) {
        emit(
          RegisterUpdated(
            email: state.email,
            emailError: errorEmail,
            password: state.password,
            passwordError: errorPassword,
            passwordConfirm: state.passwordConfirm,
            passwordConfirmError: errorConfirmPassword,
            isPasswordVisible: state.isPasswordVisible,
            isConfirmPasswordVisible: state.isConfirmPasswordVisible,
          ),
        );
        return;
      }

      await _supaRepository.sighup(
        email: state.email.trim(),
        password: state.password.trim(),
      );

      emit(
        RegisterSuccess(
          email: state.email,
          emailError: state.emailError,
          password: state.password,
          passwordError: state.passwordError,
          passwordConfirm: state.passwordConfirm,
          passwordConfirmError: state.passwordConfirmError,
          isPasswordVisible: state.isPasswordVisible,
          isConfirmPasswordVisible: state.isConfirmPasswordVisible,
        ),
      );

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
        RegisterWarning(
          message: message,
          email: state.email,
          emailError: state.emailError,
          password: state.password,
          passwordError: state.passwordError,
          passwordConfirm: state.passwordConfirm,
          passwordConfirmError: state.passwordConfirmError,
          isPasswordVisible: state.isPasswordVisible,
          isConfirmPasswordVisible: state.isConfirmPasswordVisible,
        ),
      );
    } catch (e) {
      emit(
        RegisterWarning(
          message: "Deu pau: ${e.toString()}",
          email: state.email,
          emailError: state.emailError,
          password: state.password,
          passwordError: state.passwordError,
          passwordConfirm: state.passwordConfirm,
          passwordConfirmError: state.passwordConfirmError,
          isPasswordVisible: state.isPasswordVisible,
          isConfirmPasswordVisible: state.isConfirmPasswordVisible,
        ),
      );
    }
  }
}
