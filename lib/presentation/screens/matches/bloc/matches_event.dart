part of 'matches_bloc.dart';

sealed class MatchesEvent extends Equatable {
  const MatchesEvent();
}

final class MatchesLoad extends MatchesEvent {
  const MatchesLoad();

  @override
  List<Object> get props => [];
}
