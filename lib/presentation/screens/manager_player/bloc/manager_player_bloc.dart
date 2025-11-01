import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/util/name_validator.dart';
import '../../../../data/models/player.dart';
import '../../../../domain/repositories/remote/supa_repository.dart';

part 'manager_player_event.dart';
part 'manager_player_state.dart';

class ManagerPlayerBloc extends Bloc<ManagerPlayerEvent, ManagerPlayerState> {
  ManagerPlayerBloc(this._supaRepository)
    : super(const ManagerPlayerInitial()) {
    on<ManagerPlayerLoad>(_onManagerPlayerLoad);
    on<ManagerPlayerSetName>(_onManagerPlayerSetName);
    on<ManagerPlayerSave>(_onManagerPlayerSave);
    on<ManagerPlayerDelete>(_onManagerPlayerDelete);
  }

  final SupaRepository _supaRepository;

  FutureOr<void> _onManagerPlayerLoad(
    ManagerPlayerLoad event,
    Emitter<ManagerPlayerState> emit,
  ) async {
    try {
      emit(const ManagerPlayerLoading());

      final String? id = event.id;

      Player? player;

      if (id != null) {
        player = await _supaRepository.loadPlayerById(id);
      }

      emit(
        ManagerPlayerLoaded(
          id: id,
          name: player?.name ?? "",
          player: player,
          nameError: null,
        ),
      );
    } catch (_) {
      emit(
        ManagerPlayerLoadFail(
          id: event.id,
          message:
              "Não foi encontrar os dados do usuário. "
              "Tente novamente em breve.",
        ),
      );
    }
  }

  FutureOr<void> _onManagerPlayerSetName(
    ManagerPlayerSetName event,
    Emitter<ManagerPlayerState> emit,
  ) {
    emit(
      ManagerPlayerLoaded(
        id: state.id,
        name: event.value,
        player: state.player,
        nameError: null,
      ),
    );
  }

  FutureOr<void> _onManagerPlayerSave(
    ManagerPlayerSave event,
    Emitter<ManagerPlayerState> emit,
  ) async {
    try {
      if (state is ManagerPlayerSaving) {
        return;
      }

      emit(
        ManagerPlayerSaving(
          id: state.id,
          name: state.name,
          player: state.player,
          nameError: null,
        ),
      );

      final String name = state.name.trim();

      if (name.isEmpty) {
        emit(
          ManagerPlayerLoaded(
            id: state.id,
            name: state.name,
            player: state.player,
            nameError: 'O nome do jogador não pode ficar vazio.',
          ),
        );
        return;
      }

      if (name.length < 2) {
        emit(
          ManagerPlayerLoaded(
            id: state.id,
            name: state.name,
            player: state.player,
            nameError: 'O nome do jogador precisa ter pelo menos duas letras.',
          ),
        );
        return;
      }

      if (name.length > 20) {
        emit(
          ManagerPlayerLoaded(
            id: state.id,
            name: state.name,
            player: state.player,
            nameError: 'O nome do jogador não pode ter mais que 20 letras.',
          ),
        );
        return;
      }

      if (!StringValidator.isValidLettersAndSingleSpace(name)) {
        emit(
          ManagerPlayerLoaded(
            id: state.id,
            name: state.name,
            player: state.player,
            nameError:
                'O nome do jogador pode conter apenas letras e '
                'um único espaço entre os caracteres.',
          ),
        );
        return;
      }

      final user = _supaRepository.getUser();

      if (user == null) {
        emit(
          ManagerPlayerWarning(
            id: state.id,
            name: state.name,
            player: state.player,
            nameError: null,
            message: 'Usuário de integração não encontrado.',
          ),
        );
        return;
      }

      final String? id = state.player?.id;

      if (id == null) {
        await _supaRepository.insertPlayer(name: name, createdBy: user.id);
      } else {
        await _supaRepository.updatePlayer(name: name, id: id);
      }

      emit(
        ManagerPlayerSuccess(
          id: state.id,
          name: state.name,
          player: state.player,
          nameError: null,
          message: id == null ? 'Jogador incluído' : 'Jogador atualizado',
        ),
      );
    } catch (e) {
      emit(
        ManagerPlayerWarning(
          id: state.id,
          name: state.name,
          player: state.player,
          nameError: state.nameError,
          message:
              'Um erro inesperado aconteceu, '
              'tente novamente em breve.\n${e.toString()}.',
        ),
      );
    }
  }

  FutureOr<void> _onManagerPlayerDelete(
    ManagerPlayerDelete event,
    Emitter<ManagerPlayerState> emit,
  ) async {
    try {
      if (state is ManagerPlayerSaving) {
        return;
      }

      emit(
        ManagerPlayerSaving(
          id: state.id,
          name: state.name,
          player: state.player,
          nameError: state.nameError,
        ),
      );

      final String? id = state.player?.id;

      if (id != null) {
        await _supaRepository.deletePlayer(id: id);

        emit(
          ManagerPlayerSuccess(
            id: state.id,
            name: state.name,
            player: state.player,
            nameError: state.nameError,
            message: 'Jogador removido com sucesso!',
          ),
        );
      } else {
        emit(
          ManagerPlayerWarning(
            id: state.id,
            name: state.name,
            player: state.player,
            nameError: state.nameError,
            message: 'Jogador não encontrado.',
          ),
        );
      }
    } catch (e) {
      emit(
        ManagerPlayerWarning(
          id: state.id,
          name: state.name,
          player: state.player,
          nameError: state.nameError,
          message:
              'Um erro inesperado aconteceu ao remover o jogador, '
              'tente novamente em breve.\n${e.toString()}',
        ),
      );
    }
  }
}
