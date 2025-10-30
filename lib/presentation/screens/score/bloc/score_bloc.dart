import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/match.dart';
import '../../../../domain/repositories/remote/supa_repository.dart';

part 'score_event.dart';
part 'score_state.dart';

class ScoreBloc extends Bloc<ScoreEvent, ScoreState> {
  ScoreBloc(this._supaRepository) : super(const ScoreInitial()) {
    on<ScoreLoad>(_onScoreLoad);
    on<ScoreDecreaseHome>(_onScoreDecreaseHome);
    on<ScoreDecreaseAway>(_onScoreDecreaseAway);
    on<ScoreIncreaseHome>(_onScoreIncreaseHome);
    on<ScoreIncreaseAway>(_onScoreIncreaseAway);
  }

  final SupaRepository _supaRepository;

  FutureOr<void> _onScoreLoad(ScoreLoad event, Emitter<ScoreState> emit) async {
    try {
      emit(const ScoreLoading());

      final user = _supaRepository.getUser();

      if (user == null) {
        throw "Usuario nao encontrado.";
      }

      final Match? match = await _supaRepository.loadMatchById(event.id);

      if (match == null) {
        throw "Partida não encontrada.";
      }

      emit(
        ScoreLoaded(
          id: event.id,
          homeTeamName: match.homeTeamName,
          awayTeamName: match.awayTeamName,
          homeScore: match.homeScore,
          awayScore: match.awayScore,
        ),
      );
    } catch (e) {
      emit(
        ScoreLoadFail(
          id: event.id,
          message:
              "Não foi possível carregar o placar da partida.\n${e.toString()}",
        ),
      );
    }
  }

  FutureOr<void> _onScoreDecreaseHome(
    ScoreDecreaseHome event,
    Emitter<ScoreState> emit,
  ) async {
    if (state is ScoreSaving) {
      return;
    }

    final oldScore = state.homeScore;
    final newScore = max(oldScore - 1, 0);

    try {
      emit(
        ScoreSaving(
          id: state.id,
          homeTeamName: state.homeTeamName,
          awayTeamName: state.awayTeamName,
          homeScore: newScore,
          awayScore: state.awayScore,
        ),
      );

      await _supaRepository.updateMatchHomeScore(state.id, newScore);

      emit(
        ScoreLoaded(
          id: state.id,
          homeTeamName: state.homeTeamName,
          awayTeamName: state.awayTeamName,
          homeScore: newScore,
          awayScore: state.awayScore,
        ),
      );
    } catch (e) {
      emit(
        ScoreWarning(
          message: "Não foi possível atualizar o placar.\n${e.toString()}",
          id: state.id,
          homeTeamName: state.homeTeamName,
          awayTeamName: state.awayTeamName,
          homeScore: oldScore,
          awayScore: state.awayScore,
        ),
      );
    }
  }

  FutureOr<void> _onScoreDecreaseAway(
    ScoreDecreaseAway event,
    Emitter<ScoreState> emit,
  ) async {
    if (state is ScoreSaving) {
      return;
    }

    final oldScore = state.awayScore;
    final newScore = max(oldScore - 1, 0);

    try {
      emit(
        ScoreSaving(
          id: state.id,
          homeTeamName: state.homeTeamName,
          awayTeamName: state.awayTeamName,
          homeScore: state.homeScore,
          awayScore: newScore,
        ),
      );

      await _supaRepository.updateMatchAwayScore(state.id, newScore);

      emit(
        ScoreLoaded(
          id: state.id,
          homeTeamName: state.homeTeamName,
          awayTeamName: state.awayTeamName,
          homeScore: state.homeScore,
          awayScore: newScore,
        ),
      );
    } catch (e) {
      emit(
        ScoreWarning(
          message: "Não foi possível atualizar o placar.\n${e.toString()}",
          id: state.id,
          homeTeamName: state.homeTeamName,
          awayTeamName: state.awayTeamName,
          homeScore: state.homeScore,
          awayScore: oldScore,
        ),
      );
    }
  }

  FutureOr<void> _onScoreIncreaseHome(
    ScoreIncreaseHome event,
    Emitter<ScoreState> emit,
  ) async {
    if (state is ScoreSaving) {
      return;
    }

    final oldScore = state.homeScore;
    final newScore = min(oldScore + 1, 99);

    try {
      emit(
        ScoreSaving(
          id: state.id,
          homeTeamName: state.homeTeamName,
          awayTeamName: state.awayTeamName,
          homeScore: newScore,
          awayScore: state.awayScore,
        ),
      );

      await _supaRepository.updateMatchHomeScore(state.id, newScore);

      emit(
        ScoreLoaded(
          id: state.id,
          homeTeamName: state.homeTeamName,
          awayTeamName: state.awayTeamName,
          homeScore: newScore,
          awayScore: state.awayScore,
        ),
      );
    } catch (e) {
      emit(
        ScoreWarning(
          message: "Não foi possível atualizar o placar.\n${e.toString()}",
          id: state.id,
          homeTeamName: state.homeTeamName,
          awayTeamName: state.awayTeamName,
          homeScore: oldScore,
          awayScore: state.awayScore,
        ),
      );
    }
  }

  FutureOr<void> _onScoreIncreaseAway(
    ScoreIncreaseAway event,
    Emitter<ScoreState> emit,
  ) async {
    if (state is ScoreSaving) {
      return;
    }

    final oldScore = state.awayScore;
    final newScore = min(oldScore + 1, 99);

    try {
      emit(
        ScoreSaving(
          id: state.id,
          homeTeamName: state.homeTeamName,
          awayTeamName: state.awayTeamName,
          homeScore: state.homeScore,
          awayScore: newScore,
        ),
      );

      await _supaRepository.updateMatchAwayScore(state.id, newScore);

      emit(
        ScoreLoaded(
          id: state.id,
          homeTeamName: state.homeTeamName,
          awayTeamName: state.awayTeamName,
          homeScore: state.homeScore,
          awayScore: newScore,
        ),
      );
    } catch (e) {
      emit(
        ScoreWarning(
          message: "Não foi possível atualizar o placar.\n${e.toString()}",
          id: state.id,
          homeTeamName: state.homeTeamName,
          awayTeamName: state.awayTeamName,
          homeScore: state.homeScore,
          awayScore: oldScore,
        ),
      );
    }
  }
}
