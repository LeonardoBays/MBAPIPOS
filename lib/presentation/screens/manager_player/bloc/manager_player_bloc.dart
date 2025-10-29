import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/player.dart';
import '../../../../domain/repositories/remote/supa_repository.dart';

part 'manager_player_event.dart';
part 'manager_player_state.dart';

class ManagerPlayerBloc extends Bloc<ManagerPlayerEvent, ManagerPlayerState> {
  ManagerPlayerBloc(this._supaRepository)
    : super(const ManagerPlayerInitial()) {
    on<ManagerPlayerLoad>(_onManagerPlayerLoad);
  }

  final SupaRepository _supaRepository;

  FutureOr<void> _onManagerPlayerLoad(
    ManagerPlayerLoad event,
    Emitter<ManagerPlayerState> emit,
  ) async {
    try {} catch (_) {}
  }
}
