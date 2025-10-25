part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState({
    this.email = "",
    this.emailError,
    this.password = "",
    this.passwordError,
    this.isPasswordVisible = false,
  });

  final String email;
  final String? emailError;

  final String password;
  final String? passwordError;

  final bool isPasswordVisible;
}

final class LoginInitial extends LoginState {
  const LoginInitial();

  @override
  List<Object> get props => [];
}

final class LoginLoading extends LoginState {
  const LoginLoading({
    super.email,
    super.emailError,
    super.password,
    super.passwordError,
    super.isPasswordVisible,
  });

  @override
  List<Object?> get props => [
    email,
    emailError,
    password,
    passwordError,
    isPasswordVisible,
  ];
}

final class LoginUpdated extends LoginState {
  const LoginUpdated({
    super.email,
    super.emailError,
    super.password,
    super.passwordError,
    super.isPasswordVisible,
  });

  @override
  List<Object?> get props => [
    email,
    emailError,
    password,
    passwordError,
    isPasswordVisible,
  ];
}

final class LoginWarning extends LoginState {
  const LoginWarning({
    required this.message,
    super.email,
    super.emailError,
    super.password,
    super.passwordError,
    super.isPasswordVisible,
  });

  final String message;

  @override
  List<Object?> get props => [
    message,
    email,
    emailError,
    password,
    passwordError,
    isPasswordVisible,
  ];
}
