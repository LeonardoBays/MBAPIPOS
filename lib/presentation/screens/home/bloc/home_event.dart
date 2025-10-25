part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();
}

final class HomeLogout extends HomeEvent {
  const HomeLogout();

  @override
  List<Object> get props => [];
}


final class HomeReset extends HomeEvent {
  const HomeReset();

  @override
  List<Object> get props => [];
}
