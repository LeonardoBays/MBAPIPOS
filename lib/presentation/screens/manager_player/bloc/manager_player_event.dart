part of 'manager_player_bloc.dart';

sealed class ManagerPlayerEvent extends Equatable {
  const ManagerPlayerEvent();
}

final class ManagerPlayerLoad extends ManagerPlayerEvent {
  const ManagerPlayerLoad(this.id);

  final String? id;

  @override
  List<Object?> get props => [id];
}