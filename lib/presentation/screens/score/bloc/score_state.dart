part of 'score_bloc.dart';

sealed class ScoreState extends Equatable {
  const ScoreState({
    this.id = '',
    this.homeTeamName = '',
    this.awayTeamName = '',
    this.homeScore = 0,
    this.awayScore = 0,
  });

  final String id;
  final String homeTeamName;
  final String awayTeamName;
  final int homeScore;
  final int awayScore;
}

final class ScoreInitial extends ScoreState {
  const ScoreInitial();

  @override
  List<Object> get props => [];
}

final class ScoreLoading extends ScoreState {
  const ScoreLoading();

  @override
  List<Object> get props => [];
}

final class ScoreLoaded extends ScoreState {
  const ScoreLoaded({
    required super.id,
    required super.homeTeamName,
    required super.awayTeamName,
    required super.homeScore,
    required super.awayScore,
  });

  @override
  List<Object> get props => [
    id,
    homeTeamName,
    awayTeamName,
    homeScore,
    awayScore,
  ];
}

final class ScoreSaving extends ScoreState {
  const ScoreSaving({
    required super.id,
    required super.homeTeamName,
    required super.awayTeamName,
    required super.homeScore,
    required super.awayScore,
  });

  @override
  List<Object> get props => [
    id,
    homeTeamName,
    awayTeamName,
    homeScore,
    awayScore,
  ];
}

final class ScoreLoadFail extends ScoreState {
  const ScoreLoadFail({required super.id, required this.message});

  final String message;

  @override
  List<Object> get props => [id, message];
}

final class ScoreWarning extends ScoreState {
  const ScoreWarning({
    required this.message,
    required super.id,
    required super.homeTeamName,
    required super.awayTeamName,
    required super.homeScore,
    required super.awayScore,
  });

  final String message;

  @override
  List<Object> get props => [
    id,
    message,
    homeTeamName,
    awayTeamName,
    homeScore,
    awayScore,
  ];
}
