part of 'score_bloc.dart';

sealed class ScoreEvent extends Equatable {
  const ScoreEvent();
}

final class ScoreLoad extends ScoreEvent {
  const ScoreLoad(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

final class ScoreDecreaseHome extends ScoreEvent {
  const ScoreDecreaseHome();

  @override
  List<Object> get props => [];
}

final class ScoreDecreaseAway extends ScoreEvent {
  const ScoreDecreaseAway();

  @override
  List<Object> get props => [];
}

final class ScoreIncreaseHome extends ScoreEvent {
  const ScoreIncreaseHome();

  @override
  List<Object> get props => [];
}

final class ScoreIncreaseAway extends ScoreEvent {
  const ScoreIncreaseAway();

  @override
  List<Object> get props => [];
}
