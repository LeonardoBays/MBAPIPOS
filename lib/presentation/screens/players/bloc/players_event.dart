part of 'players_bloc.dart';

sealed class PlayersEvent extends Equatable {
  const PlayersEvent();
}

final class PlayersLoad extends PlayersEvent {
  const PlayersLoad();

  @override
  List<Object> get props => [];
}
