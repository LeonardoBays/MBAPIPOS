import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
      final user = _supaRepository.getUser();

      if (user == null) {
        throw "Usuario nao encontrado.";
      }

      // await _supaRepository.insertPlayer(
      //   createdBy: user.id,
      //   name: "Leonardo Bays",
      // );

      final players = await _supaRepository.loadPlayers(user.id);

      // await _supaRepository.deletePlayer(id: players.first.id!);
      // await _supaRepository.updatePlayer(
      //   id: players.first.id!,
      //   name: "Dida",
      // );

      emit(const PlayersLoaded());
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
