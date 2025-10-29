import 'package:flutter/material.dart';

import '../injector.dart';
import '../presentation/components/animation/modal_page_route.dart';
import '../presentation/screens/authentication/authentication_screen.dart';
import '../presentation/screens/authentication/bloc/authentication_bloc.dart';
import '../presentation/screens/home/bloc/home_bloc.dart';
import '../presentation/screens/login/bloc/login_bloc.dart';
import '../presentation/screens/manager_player/bloc/manager_player_bloc.dart';
import '../presentation/screens/manager_player/manager_player_screen.dart';
import '../presentation/screens/players/bloc/players_bloc.dart';
import '../presentation/screens/players/players_screen.dart';
import '../presentation/screens/register/bloc/register_bloc.dart';
import '../presentation/screens/register/register_screen.dart';

enum NavigationFlow { simple, modalBottomUp }

enum AppRoutes {
  root('/', NavigationFlow.simple),
  register('/register', NavigationFlow.simple),
  players('/players', NavigationFlow.simple),
  managerPlayer('/manager_player', NavigationFlow.simple),
  matches('/matches', NavigationFlow.simple),
  managerMatch('/manager_match', NavigationFlow.simple),
  ranking('/hiscores', NavigationFlow.simple);

  final String route;
  final NavigationFlow flow;

  const AppRoutes(this.route, this.flow);

  static AppRoutes fromName(String? screenName) {
    return AppRoutes.values.firstWhere(
      (e) => e.route == screenName,
      orElse: () => root,
    );
  }
}

class Routes {
  static PageRoute router(RouteSettings settings, Injector injector) {
    final appRoute = AppRoutes.fromName(settings.name);

    final Widget screen = switch (appRoute) {
      AppRoutes.root => AuthenticationScreen(
        authenticationBloc: injector.getIt.get<AuthenticationBloc>(),
        loginBloc: injector.getIt.get<LoginBloc>(),
        homeBloc: injector.getIt.get<HomeBloc>(),
      ),
      AppRoutes.register => RegisterScreen(
        registerBloc: injector.getIt.get<RegisterBloc>(),
      ),
      AppRoutes.players => PlayersScreen(
        playersBloc: injector.getIt.get<PlayersBloc>(),
      ),
      AppRoutes.managerPlayer => ManagerPlayerScreen(
        managerPlayerBloc: injector.getIt.get<ManagerPlayerBloc>(),
        id: settings.arguments as String?,
      ),
      AppRoutes.matches => PlayersScreen(
        playersBloc: injector.getIt.get<PlayersBloc>(),
      ),
      AppRoutes.managerMatch => PlayersScreen(
        playersBloc: injector.getIt.get<PlayersBloc>(),
      ),
      AppRoutes.ranking => PlayersScreen(
        playersBloc: injector.getIt.get<PlayersBloc>(),
      ),
    };

    return switch (appRoute.flow) {
      NavigationFlow.modalBottomUp => ModalPageRoute(
        builder: (context) => screen,
        modalSettings: settings,
      ),
      NavigationFlow.simple => MaterialPageRoute(
        builder: (context) => screen,
        settings: settings,
      ),
    };
  }
}
