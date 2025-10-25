part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();
}

final class RegisterSetEmail extends RegisterEvent {
  const RegisterSetEmail(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

final class RegisterSetPassword extends RegisterEvent {
  const RegisterSetPassword(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

final class RegisterSetConfirmPassword extends RegisterEvent {
  const RegisterSetConfirmPassword(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

final class RegisterTogglePassword extends RegisterEvent {
  const RegisterTogglePassword();

  @override
  List<Object> get props => [];
}

final class RegisterToggleConfirmPassword extends RegisterEvent {
  const RegisterToggleConfirmPassword();

  @override
  List<Object> get props => [];
}

final class RegisterRequest extends RegisterEvent {
  const RegisterRequest();

  @override
  List<Object> get props => [];
}
