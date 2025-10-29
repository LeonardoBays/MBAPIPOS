part of 'manager_player_bloc.dart';

sealed class ManagerPlayerState extends Equatable {
  const ManagerPlayerState({this.id, this.player, this.name = ''});

  final String? id;
  final Player? player;
  final String name;
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
    required super.player,
  });

  @override
  List<Object?> get props => [id, name, player];
}

final class ManagerPlayerLoadFail extends ManagerPlayerState {
  const ManagerPlayerLoadFail({required super.id, required this.message});

  final String message;

  @override
  List<Object?> get props => [id, message];
}
