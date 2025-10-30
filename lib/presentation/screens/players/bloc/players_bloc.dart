import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/player.dart';
import '../../../../domain/repositories/remote/supa_repository.dart';

part 'players_event.dart';
part 'players_state.dart';

class PlayersBloc extends Bloc<PlayersEvent, PlayersState> {
  PlayersBloc(this._supaRepository) : super(const PlayersInitial()) {
    on<PlayersLoad>(_onPlayersLoad);
  }

  final SupaRepository _supaRepository;

  FutureOr<void> _onPlayersLoad(
    PlayersLoad event,
    Emitter<PlayersState> emit,
  ) async {
    try {
      emit(const PlayersLoading());

      final user = _supaRepository.getUser();

      if (user == null) {
        throw "Usuario nao encontrado.";
      }

      final players = await _supaRepository.loadPlayers(user.id);

      if (players.isNotEmpty) {
        emit(PlayersLoaded(players: players));
      } else {
        emit(const PlayersLoadedEmpty());
      }
    } catch (e) {
      emit(
        PlayersLoadFail(
          message:
              "Não foi possível carregar a "
              "lista de jogadores.\n${e.toString()}",
        ),
      );
    }
  }
}
