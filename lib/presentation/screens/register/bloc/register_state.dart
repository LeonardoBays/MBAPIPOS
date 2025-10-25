part of 'register_bloc.dart';

sealed class RegisterState extends Equatable {
  const RegisterState({
    this.email = "",
    this.emailError,
    this.password = "",
    this.passwordError,
    this.passwordConfirm = "",
    this.passwordConfirmError,
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
  });

  final String email;
  final String? emailError;

  final String password;
  final String? passwordError;

  final String passwordConfirm;
  final String? passwordConfirmError;

  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
}

final class RegisterInitial extends RegisterState {
  const RegisterInitial();

  @override
  List<Object> get props => [];
}

final class RegisterLoading extends RegisterState {
  const RegisterLoading({
    super.email,
    super.emailError,
    super.password,
    super.passwordError,
    super.passwordConfirm,
    super.passwordConfirmError,
    super.isPasswordVisible,
    super.isConfirmPasswordVisible,
  });

  @override
  List<Object?> get props => [
    email,
    passwordConfirm,
    passwordConfirmError,
    emailError,
    password,
    passwordError,
    isPasswordVisible,
    isConfirmPasswordVisible,
  ];
}

final class RegisterUpdated extends RegisterState {
  const RegisterUpdated({
    super.email,
    super.emailError,
    super.password,
    super.passwordError,
    super.passwordConfirm,
    super.passwordConfirmError,
    super.isPasswordVisible,
    super.isConfirmPasswordVisible,
  });

  @override
  List<Object?> get props => [
    email,
    passwordConfirm,
    passwordConfirmError,
    emailError,
    password,
    passwordError,
    isPasswordVisible,
    isConfirmPasswordVisible,
  ];
}

final class RegisterWarning extends RegisterState {
  const RegisterWarning({
    required this.message,
    super.email,
    super.emailError,
    super.password,
    super.passwordError,
    super.passwordConfirm,
    super.passwordConfirmError,
    super.isPasswordVisible,
    super.isConfirmPasswordVisible,
  });

  final String message;

  @override
  List<Object?> get props => [
    message,
    email,
    emailError,
    passwordConfirm,
    passwordConfirmError,
    password,
    passwordError,
    isPasswordVisible,
    isConfirmPasswordVisible,
  ];
}


final class RegisterSuccess extends RegisterState {
  const RegisterSuccess({
    super.email,
    super.emailError,
    super.password,
    super.passwordError,
    super.passwordConfirm,
    super.passwordConfirmError,
    super.isPasswordVisible,
    super.isConfirmPasswordVisible,
  });


  @override
  List<Object?> get props => [
    email,
    emailError,
    passwordConfirm,
    passwordConfirmError,
    password,
    passwordError,
    isPasswordVisible,
    isConfirmPasswordVisible,
  ];
}
