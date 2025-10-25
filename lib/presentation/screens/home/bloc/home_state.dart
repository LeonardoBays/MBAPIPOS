part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();
}

final class HomeInitial extends HomeState {
  const HomeInitial();

  @override
  List<Object> get props => [];
}

final class HomeWarning extends HomeState {
  const HomeWarning({
    required this.message,
  });

  final String message;

  @override
  List<Object?> get props => [
    message,
  ];
}
