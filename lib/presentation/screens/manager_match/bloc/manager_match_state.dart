part of 'manager_match_bloc.dart';

sealed class ManagerMatchState extends Equatable {
  const ManagerMatchState({
    this.match,
    this.id,
    this.homeName = '',
    this.awayName = '',
    this.homeNameError,
    this.awayNameError,
    this.startAt,
    this.endAt,
    this.players = const [],
    this.homePlayers = const [],
    this.awayPlayers = const [],
  });

  final Match? match;

  final String homeName;
  final String awayName;

  final String? homeNameError;
  final String? awayNameError;

  final DateTime? startAt;
  final DateTime? endAt;

  final List<Player> players;
  final List<Player> homePlayers;
  final List<Player> awayPlayers;

  final String? id;

  bool get hasPlayer => match != null;
}

final class ManagerMatchInitial extends ManagerMatchState {
  const ManagerMatchInitial();

  @override
  List<Object> get props => [];
}

final class ManagerMatchLoading extends ManagerMatchState {
  const ManagerMatchLoading();

  @override
  List<Object> get props => [];
}

final class ManagerMatchLoaded extends ManagerMatchState {
  const ManagerMatchLoaded({
    required super.id,
    required super.match,
    required super.homeName,
    required super.awayName,
    required super.homeNameError,
    required super.awayNameError,
    required super.startAt,
    required super.endAt,
    required super.players,
    required super.homePlayers,
    required super.awayPlayers,
  });

  @override
  List<Object?> get props => [
    id,
    match,
    homeName,
    awayName,
    homeNameError,
    awayNameError,
    startAt,
    endAt,
    players,
    homePlayers,
    awayPlayers,
  ];
}

final class ManagerMatchLoadFail extends ManagerMatchState {
  const ManagerMatchLoadFail({
    required this.message,
    required super.id,
    required super.match,
    required super.homeName,
    required super.awayName,
    required super.homeNameError,
    required super.awayNameError,
    required super.startAt,
    required super.endAt,
    required super.players,
    required super.homePlayers,
    required super.awayPlayers,
  });

  final String message;

  @override
  List<Object?> get props => [
    message,
    id,
    match,
    homeName,
    awayName,
    homeNameError,
    awayNameError,
    startAt,
    endAt,
    players,
    homePlayers,
    awayPlayers,
  ];
}

final class ManagerMatchSaving extends ManagerMatchState {
  const ManagerMatchSaving({
    required super.id,
    required super.match,
    required super.homeName,
    required super.awayName,
    required super.homeNameError,
    required super.awayNameError,
    required super.startAt,
    required super.endAt,
    required super.players,
    required super.homePlayers,
    required super.awayPlayers,
  });

  @override
  List<Object?> get props => [
    id,
    match,
    homeName,
    awayName,
    homeNameError,
    awayNameError,
    startAt,
    endAt,
    players,
    homePlayers,
    awayPlayers,
  ];
}

final class ManagerMatchWarning extends ManagerMatchState {
  const ManagerMatchWarning({
    required this.message,
    required super.id,
    required super.match,
    required super.homeName,
    required super.awayName,
    required super.homeNameError,
    required super.awayNameError,
    required super.startAt,
    required super.endAt,
    required super.players,
    required super.homePlayers,
    required super.awayPlayers,
  });

  final String message;

  @override
  List<Object?> get props => [
    message,
    id,
    match,
    homeName,
    awayName,
    homeNameError,
    awayNameError,
    startAt,
    endAt,
    players,
    homePlayers,
    awayPlayers,
  ];
}

final class ManagerMatchSuccess extends ManagerMatchState {
  const ManagerMatchSuccess({
    required this.message,
    required super.id,
    required super.match,
    required super.homeName,
    required super.awayName,
    required super.homeNameError,
    required super.awayNameError,
    required super.startAt,
    required super.endAt,
    required super.players,
    required super.homePlayers,
    required super.awayPlayers,
  });

  final String message;

  @override
  List<Object?> get props => [
    message,
    id,
    match,
    homeName,
    awayName,
    homeNameError,
    awayNameError,
    startAt,
    endAt,
    players,
    homePlayers,
    awayPlayers,
  ];
}
