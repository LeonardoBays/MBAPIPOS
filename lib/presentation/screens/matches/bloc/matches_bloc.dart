import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/match.dart';
import '../../../../domain/repositories/remote/supa_repository.dart';

part 'matches_event.dart';

part 'matches_state.dart';

class MatchesBloc extends Bloc<MatchesEvent, MatchesState> {
  MatchesBloc(this._supaRepository) : super(const MatchesInitial()) {
    on<MatchesLoad>(_onMatchesLoad);
  }

  final SupaRepository _supaRepository;

  FutureOr<void> _onMatchesLoad(
    MatchesLoad event,
    Emitter<MatchesState> emit,
  ) async {
    try {
      emit(const MatchesLoading());

      final user = _supaRepository.getUser();

      if (user == null) {
        throw "Usuario nao encontrado.";
      }

      final List<Match> matches = await _supaRepository.loadMatches(user.id);

      // await _supaRepository.insertMatch(
      //   startAt: DateTime.now().add(const Duration(minutes: 3)),
      //   endAt: DateTime.now().add(const Duration(minutes: 10 + 90)),
      //   homeTeamName: 'Time da casa',
      //   awayTeamName: 'Time visitante',
      //   createdBy: user.id,
      // );

      if (matches.isNotEmpty) {
        emit(MatchesLoaded(matches: matches));
      } else {
        emit(const MatchesLoadedEmpty());
      }
    } catch (e) {
      emit(
        MatchesLoadFail(
          message:
              "Não foi possível carregar a "
              "lista de partidas.\n${e.toString()}",
        ),
      );
    }
  }
}
