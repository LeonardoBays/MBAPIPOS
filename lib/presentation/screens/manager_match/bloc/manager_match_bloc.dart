import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/constants/enum/match_team.dart';
import '../../../../data/models/match.dart';
import '../../../../data/models/player.dart';
import '../../../../domain/repositories/remote/supa_repository.dart';

part 'manager_match_event.dart';
part 'manager_match_state.dart';

class ManagerMatchBloc extends Bloc<ManagerMatchEvent, ManagerMatchState> {
  ManagerMatchBloc(this._supaRepository) : super(const ManagerMatchInitial()) {
    on<ManagerMatchLoad>(_onManagerMatchLoad);
  }

  late final SupaRepository _supaRepository;

  FutureOr<void> _onManagerMatchLoad(
    ManagerMatchLoad event,
    Emitter<ManagerMatchState> emit,
  ) async {
    try {
      emit(const ManagerMatchLoading());

      final String? id = event.id;

      final User? user = _supaRepository.getUser();

      if (user == null) {
        throw "Usuario não encontrado";
      }

      Match? match;

      if (id != null) {
        match = await _supaRepository.loadMatchById(id);
      }

      List<Player> players = await _supaRepository.loadPlayers(user.id);
      List<Player> homePlayers = [];
      List<Player> awayPlayers = [];

      if (match != null) {
        homePlayers = await _supaRepository.loadPlayersByMatch(
          match.id,
          MatchTeam.local,
        );
        awayPlayers = await _supaRepository.loadPlayersByMatch(
          match.id,
          MatchTeam.away,
        );
      }

      emit(
        ManagerMatchLoaded(
          id: event.id,
          match: match,
          homeName: match?.homeTeamName ?? '',
          awayName: match?.awayTeamName ?? '',
          homeNameError: null,
          awayNameError: null,
          startAt: match?.startAt,
          endAt: match?.endAt,
          players: players,
          homePlayers: homePlayers,
          awayPlayers: awayPlayers,
        ),
      );
    } catch (e) {
      emit(
        ManagerMatchLoadFail(
          id: event.id,
          message: "Ops, algo de errado aconteceu.\n${e.toString()}",
          match: state.match,
          homeName: state.homeName,
          awayName: state.awayName,
          homeNameError: state.homeNameError,
          awayNameError: state.awayNameError,
          startAt: state.startAt,
          endAt: state.endAt,
          players: state.players,
          homePlayers: state.homePlayers,
          awayPlayers: state.awayPlayers,
        ),
      );
    }
  }
}
