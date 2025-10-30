part of 'manager_player_bloc.dart';

sealed class ManagerPlayerState extends Equatable {
  const ManagerPlayerState({
    this.id,
    this.player,
    this.name = '',
    this.nameError,
  });

  final String? id;
  final Player? player;
  final String name;
  final String? nameError;

  bool get hasPlayer => player != null;

}

final class ManagerPlayerInitial extends ManagerPlayerState {
  const ManagerPlayerInitial();

  @override
  List<Object> get props => [];
}

final class ManagerPlayerLoading extends ManagerPlayerState {
  const ManagerPlayerLoading();

  @override
  List<Object> get props => [];
}

final class ManagerPlayerLoaded extends ManagerPlayerState {
  const ManagerPlayerLoaded({
    required super.id,
    required super.name,
    required super.nameError,
    required super.player,
  });

  @override
  List<Object?> get props => [id, name, nameError, player];
}

final class ManagerPlayerSaving extends ManagerPlayerState {
  const ManagerPlayerSaving({
    required super.id,
    required super.name,
    required super.nameError,
    required super.player,
  });

  @override
  List<Object?> get props => [id, name, nameError, player];
}

final class ManagerPlayerSuccess extends ManagerPlayerState {
  const ManagerPlayerSuccess({
    required super.id,
    required super.name,
    required super.nameError,
    required super.player,
    required this.message,
  });

  final String message;

  @override
  List<Object?> get props => [id, name, nameError, player, message];
}

final class ManagerPlayerWarning extends ManagerPlayerState {
  const ManagerPlayerWarning({
    required super.id,
    required super.name,
    required super.nameError,
    required super.player,
    required this.message,
  });

  final String message;

  @override
  List<Object?> get props => [id, name, nameError, player, message];
}

final class ManagerPlayerLoadFail extends ManagerPlayerState {
  const ManagerPlayerLoadFail({required super.id, required this.message});

  final String message;

  @override
  List<Object?> get props => [id, message];
}
