part of 'matches_bloc.dart';

sealed class MatchesState extends Equatable {
  const MatchesState({this.matches = const []});

  final List<Match> matches;
}

final class MatchesInitial extends MatchesState {
  const MatchesInitial();

  @override
  List<Object> get props => [];
}

final class MatchesLoading extends MatchesState {
  const MatchesLoading();

  @override
  List<Object> get props => [];
}

final class MatchesLoaded extends MatchesState {
  const MatchesLoaded({required super.matches});

  @override
  List<Object> get props => [matches];
}

final class MatchesLoadedEmpty extends MatchesState {
  const MatchesLoadedEmpty();

  @override
  List<Object> get props => [];
}

final class MatchesLoadFail extends MatchesState {
  const MatchesLoadFail({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
