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

final class ManagerPlayerSetName extends ManagerPlayerEvent {
  const ManagerPlayerSetName(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

final class ManagerPlayerSave extends ManagerPlayerEvent {
  const ManagerPlayerSave();

  @override
  List<Object?> get props => [];
}

final class ManagerPlayerDelete extends ManagerPlayerEvent {
  const ManagerPlayerDelete();

  @override
  List<Object?> get props => [];
}
