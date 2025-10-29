part of 'players_bloc.dart';

sealed class PlayersState extends Equatable {
  const PlayersState();
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
  const PlayersLoaded();

  @override
  List<Object> get props => [];
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
