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
    on<ManagerMatchDelete>(_onManagerMatchDelete);
    on<ManagerMatchHomeName>(_onManagerMatchHomeName);
    on<ManagerMatchAwayName>(_onManagerMatchAwayName);
    on<ManagerMatchHomePlayers>(_onManagerMatchHomePlayers);
    on<ManagerMatchAwayPlayers>(_onManagerMatchAwayPlayers);
    on<ManagerMatchStartDate>(_onManagerMatchStartDate);
    on<ManagerMatchEndDate>(_onManagerMatchEndDate);
    on<ManagerMatchSave>(_onManagerMatchSave);
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
          dateError: null,
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
          dateError: state.dateError,
          startAt: state.startAt,
          endAt: state.endAt,
          players: state.players,
          homePlayers: state.homePlayers,
          awayPlayers: state.awayPlayers,
        ),
      );
    }
  }

  FutureOr<void> _onManagerMatchDelete(
    ManagerMatchDelete event,
    Emitter<ManagerMatchState> emit,
  ) async {
    try {
      if (state is ManagerMatchSaving) {
        return;
      }

      emit(
        ManagerMatchSaving(
          id: state.id,
          match: state.match,
          homeName: state.homeName,
          awayName: state.awayName,
          homeNameError: state.homeNameError,
          awayNameError: state.awayNameError,
          dateError: state.dateError,
          startAt: state.startAt,
          endAt: state.endAt,
          players: state.players,
          homePlayers: state.homePlayers,
          awayPlayers: state.awayPlayers,
        ),
      );

      final String? id = state.match?.id;

      if (id != null) {
        await _supaRepository.deleteMatch(id: id);

        emit(
          ManagerMatchSuccess(
            message: "Partida removida com sucesso!",
            id: state.id,
            match: state.match,
            homeName: state.homeName,
            awayName: state.awayName,
            homeNameError: state.homeNameError,
            awayNameError: state.awayNameError,
            dateError: state.dateError,
            startAt: state.startAt,
            endAt: state.endAt,
            players: state.players,
            homePlayers: state.homePlayers,
            awayPlayers: state.awayPlayers,
          ),
        );
      } else {
        emit(
          ManagerMatchWarning(
            message: "Partida não encontrada",
            id: state.id,
            match: state.match,
            homeName: state.homeName,
            awayName: state.awayName,
            homeNameError: state.homeNameError,
            awayNameError: state.awayNameError,
            dateError: state.dateError,
            startAt: state.startAt,
            endAt: state.endAt,
            players: state.players,
            homePlayers: state.homePlayers,
            awayPlayers: state.awayPlayers,
          ),
        );
      }
    } catch (e) {
      emit(
        ManagerMatchWarning(
          message:
              "Não conseguimos remover a partida no momento.\n${e.toString()}",
          id: state.id,
          match: state.match,
          homeName: state.homeName,
          awayName: state.awayName,
          homeNameError: state.homeNameError,
          awayNameError: state.awayNameError,
          dateError: state.dateError,
          startAt: state.startAt,
          endAt: state.endAt,
          players: state.players,
          homePlayers: state.homePlayers,
          awayPlayers: state.awayPlayers,
        ),
      );
    }
  }

  FutureOr<void> _onManagerMatchHomeName(
    ManagerMatchHomeName event,
    Emitter<ManagerMatchState> emit,
  ) {
    emit(
      ManagerMatchLoaded(
        id: state.id,
        match: state.match,
        homeName: event.value,
        awayName: state.awayName,
        homeNameError: null,
        awayNameError: state.awayNameError,
        dateError: state.dateError,
        startAt: state.startAt,
        endAt: state.endAt,
        players: state.players,
        homePlayers: state.homePlayers,
        awayPlayers: state.awayPlayers,
      ),
    );
  }

  FutureOr<void> _onManagerMatchAwayName(
    ManagerMatchAwayName event,
    Emitter<ManagerMatchState> emit,
  ) {
    emit(
      ManagerMatchLoaded(
        id: state.id,
        match: state.match,
        homeName: state.homeName,
        awayName: event.value,
        homeNameError: state.homeNameError,
        awayNameError: null,
        dateError: state.dateError,
        startAt: state.startAt,
        endAt: state.endAt,
        players: state.players,
        homePlayers: state.homePlayers,
        awayPlayers: state.awayPlayers,
      ),
    );
  }

  FutureOr<void> _onManagerMatchHomePlayers(
    ManagerMatchHomePlayers event,
    Emitter<ManagerMatchState> emit,
  ) {
    emit(
      ManagerMatchLoaded(
        id: state.id,
        match: state.match,
        homeName: state.homeName,
        awayName: state.awayName,
        homeNameError: state.homeNameError,
        awayNameError: state.awayNameError,
        dateError: state.dateError,
        startAt: state.startAt,
        endAt: state.endAt,
        players: state.players,
        homePlayers: event.players,
        awayPlayers: state.awayPlayers,
      ),
    );
  }

  FutureOr<void> _onManagerMatchAwayPlayers(
    ManagerMatchAwayPlayers event,
    Emitter<ManagerMatchState> emit,
  ) {
    emit(
      ManagerMatchLoaded(
        id: state.id,
        match: state.match,
        homeName: state.homeName,
        awayName: state.awayName,
        homeNameError: state.homeNameError,
        awayNameError: state.awayNameError,
        dateError: state.dateError,
        startAt: state.startAt,
        endAt: state.endAt,
        players: state.players,
        homePlayers: state.homePlayers,
        awayPlayers: event.players,
      ),
    );
  }

  FutureOr<void> _onManagerMatchStartDate(
    ManagerMatchStartDate event,
    Emitter<ManagerMatchState> emit,
  ) {
    emit(
      ManagerMatchLoaded(
        id: state.id,
        match: state.match,
        homeName: state.homeName,
        awayName: state.awayName,
        homeNameError: state.homeNameError,
        awayNameError: state.awayNameError,
        dateError: null,
        startAt: event.date,
        endAt: state.endAt,
        players: state.players,
        homePlayers: state.homePlayers,
        awayPlayers: state.awayPlayers,
      ),
    );
  }

  FutureOr<void> _onManagerMatchEndDate(
    ManagerMatchEndDate event,
    Emitter<ManagerMatchState> emit,
  ) {
    emit(
      ManagerMatchLoaded(
        id: state.id,
        match: state.match,
        homeName: state.homeName,
        awayName: state.awayName,
        homeNameError: state.homeNameError,
        awayNameError: state.awayNameError,
        dateError: null,
        startAt: state.startAt,
        endAt: event.date,
        players: state.players,
        homePlayers: state.homePlayers,
        awayPlayers: state.awayPlayers,
      ),
    );
  }

  FutureOr<void> _onManagerMatchSave(
    ManagerMatchSave event,
    Emitter<ManagerMatchState> emit,
  ) async {
    try {
      String? homeNameError;
      String? awayNameError;
      String? dateError;

      final String homeName = state.homeName.trim();
      final String awayName = state.awayName.trim();

      if (homeName.isEmpty) {
        homeNameError = "O nome do time local não pode ficar vazio.";
      }

      if (awayName.isEmpty) {
        awayNameError = "O nome do time local não pode ficar vazio.";
      }

      if (state.startAt == null || state.endAt == null) {
        dateError =
            "A data e hora de inicio e fim do jogo precisam ser definidas.";
      }

      if (homeNameError != null || awayNameError != null || dateError != null) {
        emit(
          ManagerMatchLoaded(
            id: state.id,
            match: state.match,
            homeName: state.homeName,
            awayName: state.awayName,
            homeNameError: homeNameError,
            awayNameError: awayNameError,
            dateError: dateError,
            startAt: state.startAt,
            endAt: state.endAt,
            players: state.players,
            homePlayers: state.homePlayers,
            awayPlayers: state.awayPlayers,
          ),
        );
        return;
      }

      if (homeName.length > 20) {
        homeNameError = "O nome do time precisa ter no máximo 20 caracteres.";
      }

      if (awayName.length > 20) {
        awayNameError = "O nome do time precisa ter no máximo 20 caracteres.";
      }

      dateError = _checkDates(startAt: state.startAt, endAt: state.endAt);

      if (homeNameError != null || awayNameError != null || dateError != null) {
        emit(
          ManagerMatchLoaded(
            id: state.id,
            match: state.match,
            homeName: state.homeName,
            awayName: state.awayName,
            homeNameError: homeNameError,
            awayNameError: awayNameError,
            dateError: dateError,
            startAt: state.startAt,
            endAt: state.endAt,
            players: state.players,
            homePlayers: state.homePlayers,
            awayPlayers: state.awayPlayers,
          ),
        );
        return;
      }

      final User? user = _supaRepository.getUser();

      if (user == null) {
        emit(
          ManagerMatchWarning(
            message: 'Usuário de integração não encontrado.',
            id: state.id,
            match: state.match,
            homeName: state.homeName,
            awayName: state.awayName,
            homeNameError: state.homeNameError,
            awayNameError: state.awayNameError,
            dateError: state.dateError,
            startAt: state.startAt,
            endAt: state.endAt,
            players: state.players,
            homePlayers: state.homePlayers,
            awayPlayers: state.awayPlayers,
          ),
        );
        return;
      }

      String? matchId = state.match?.id;

      if (matchId == null) {
        matchId = await _supaRepository.insertMatch(
          homeTeamName: homeName,
          awayTeamName: awayName,
          startAt: state.startAt ?? DateTime.now(),
          endAt: state.endAt ?? DateTime.now().add(const Duration(minutes: 90)),
          createdBy: user.id,
        );
      } else {
        await _supaRepository.updateMatch(
          id: matchId,
          startAt: state.startAt ?? DateTime.now(),
          endAt: state.endAt ?? DateTime.now().add(const Duration(minutes: 90)),
          homeTeamName: homeName,
          awayTeamName: awayName,
        );
      }

      await _supaRepository.savePlayersMatch(
        matchId: matchId,
        playersId: state.homePlayers.map<String>((e) => e.id).toList(),
        matchTeam: MatchTeam.local,
      );

      await _supaRepository.savePlayersMatch(
        matchId: matchId,
        playersId: state.awayPlayers.map<String>((e) => e.id).toList(),
        matchTeam: MatchTeam.away,
      );

      emit(
        ManagerMatchSuccess(
          message: "Partida salva com sucesso!",
          id: state.id,
          match: state.match,
          homeName: state.homeName,
          awayName: state.awayName,
          homeNameError: state.homeNameError,
          awayNameError: state.awayNameError,
          dateError: state.dateError,
          startAt: state.startAt,
          endAt: state.endAt,
          players: state.players,
          homePlayers: state.homePlayers,
          awayPlayers: state.awayPlayers,
        ),
      );
    } catch (e) {
      emit(
        ManagerMatchWarning(
          message:
              "Não conseguimos salvar a partida no momento.\n${e.toString()}",
          id: state.id,
          match: state.match,
          homeName: state.homeName,
          awayName: state.awayName,
          homeNameError: state.homeNameError,
          awayNameError: state.awayNameError,
          dateError: state.dateError,
          startAt: state.startAt,
          endAt: state.endAt,
          players: state.players,
          homePlayers: state.homePlayers,
          awayPlayers: state.awayPlayers,
        ),
      );
    }
  }

  String? _checkDates({DateTime? startAt, DateTime? endAt}) {
    if (startAt == null || endAt == null) {
      return "A data e hora de inicio e fim do jogo precisam ser definidas.";
    }

    final DateTime dtNow = DateTime.now();

    if (dtNow.isBefore(startAt)) {
      return "A data inicial precisa ser posterior a data hora atual";
    }

    if (endAt.isBefore(startAt)) {
      return "A data final precisa ser posterior a data hora inicial";
    }

    return null;
  }
}
