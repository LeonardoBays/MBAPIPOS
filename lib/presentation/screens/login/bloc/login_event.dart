part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();
}

final class LoginSetEmail extends LoginEvent {
  const LoginSetEmail(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

final class LoginSetPassword extends LoginEvent {
  const LoginSetPassword(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

final class LoginTogglePassword extends LoginEvent {
  const LoginTogglePassword();

  @override
  List<Object> get props => [];
}

final class LoginRequest extends LoginEvent {
  const LoginRequest();

  @override
  List<Object> get props => [];
}


final class LoginReset extends LoginEvent {
  const LoginReset();

  @override
  List<Object> get props => [];
}
