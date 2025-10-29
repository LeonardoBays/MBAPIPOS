import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/repositories/remote/supa_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._supaRepository) : super(const HomeInitial()) {
    on<HomeLogout>(_onHomeLogout);
    on<HomeReset>(_onHomeReset);
  }

  final SupaRepository _supaRepository;

  FutureOr<void> _onHomeLogout(
    HomeLogout event,
    Emitter<HomeState> emit,
  ) async {
    try {
      await _supaRepository.logout();
    } catch (e) {
      emit(
        HomeWarning(
          message: "Algo deu errado durante o logout.\n${e.toString()}",
        ),
      );
    }
  }

  FutureOr<void> _onHomeReset(HomeReset event, Emitter<HomeState> emit) {
    emit(const HomeInitial());
  }
}
