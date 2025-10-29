part of 'players_bloc.dart';

sealed class PlayersState extends Equatable {
  const PlayersState({this.players = const []});

  final List<Player> players;
}

final class PlayersInitial extends PlayersState {
  const PlayersInitial();

  @override
  List<Object> get props => [];
}

final class PlayersLoading extends PlayersState {
  const PlayersLoading();

  @override
  List<Object> get props => [];
}

final class PlayersLoaded extends PlayersState {
  const PlayersLoaded({required super.players});

  @override
  List<Object> get props => [players];
}

final class PlayersLoadFail extends PlayersState {
  const PlayersLoadFail({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

final class PlayersLoadedEmpty extends PlayersState {
  const PlayersLoadedEmpty();

  @override
  List<Object> get props => [];
}
