part of 'manager_match_bloc.dart';

sealed class ManagerMatchEvent extends Equatable {
  const ManagerMatchEvent();
}

final class ManagerMatchLoad extends ManagerMatchEvent {
  const ManagerMatchLoad(this.id);

  final String? id;

  @override
  List<Object?> get props => [id];
}

final class ManagerMatchDelete extends ManagerMatchEvent {
  const ManagerMatchDelete();

  @override
  List<Object?> get props => [];
}

final class ManagerMatchSave extends ManagerMatchEvent {
  const ManagerMatchSave();

  @override
  List<Object?> get props => [];
}

final class ManagerMatchHomeName extends ManagerMatchEvent {
  const ManagerMatchHomeName(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

final class ManagerMatchAwayName extends ManagerMatchEvent {
  const ManagerMatchAwayName(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

final class ManagerMatchHomePlayers extends ManagerMatchEvent {
  const ManagerMatchHomePlayers(this.players);

  final List<Player> players;

  @override
  List<Object?> get props => [players];
}

final class ManagerMatchAwayPlayers extends ManagerMatchEvent {
  const ManagerMatchAwayPlayers(this.players);

  final List<Player> players;

  @override
  List<Object?> get props => [players];
}

final class ManagerMatchStartDate extends ManagerMatchEvent {
  const ManagerMatchStartDate(this.date);

  final DateTime date;

  @override
  List<Object?> get props => [date];
}

final class ManagerMatchEndDate extends ManagerMatchEvent {
  const ManagerMatchEndDate(this.date);

  final DateTime date;

  @override
  List<Object?> get props => [date];
}

