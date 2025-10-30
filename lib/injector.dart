import 'package:get_it/get_it.dart';

import 'data/datasources/remote/supa_client.dart';
import 'data/repositories/remote/supa_repository_impl.dart';
import 'domain/repositories/remote/supa_repository.dart';
import 'external/datasources/remote/supa_client_impl.dart';
import 'external/plugins/supa_impl.dart';
import 'presentation/screens/authentication/bloc/authentication_bloc.dart';
import 'presentation/screens/home/bloc/home_bloc.dart';
import 'presentation/screens/login/bloc/login_bloc.dart';
import 'presentation/screens/manager_player/bloc/manager_player_bloc.dart';
import 'presentation/screens/matches/bloc/matches_bloc.dart';
import 'presentation/screens/players/bloc/players_bloc.dart';
import 'presentation/screens/register/bloc/register_bloc.dart';
import 'presentation/screens/score/bloc/score_bloc.dart';

final getIt = GetIt.instance;

abstract class Injector {
  Injector(this.getIt);

  late final GetIt getIt;

  void dispose();
}

final class InjectorImpl extends Injector {
  InjectorImpl._(super.getIt);

  static Future<Injector> initializeDependencies() async {
    final getIt = GetIt.instance;

    /// Plugins-----------------------------------------------------------------
    await SupaImpl().initialize();

    /// Database----------------------------------------------------------------

    /// API Client--------------------------------------------------------------
    getIt.registerSingleton<SupaClient>(SupaClientImpl(SupaImpl().client));

    /// Preferences Repository--------------------------------------------------

    /// Local Repository--------------------------------------------------------

    /// Supabase Repository-----------------------------------------------------
    getIt.registerSingleton<SupaRepository>(
      SupaRepositoryImpl(getIt.get<SupaClient>()),
    );

    /// Controller--------------------------------------------------------------

    /// BLoC--------------------------------------------------------------------
    getIt.registerSingleton<AuthenticationBloc>(AuthenticationBloc());

    getIt.registerSingleton<LoginBloc>(LoginBloc(getIt.get<SupaRepository>()));

    getIt.registerSingleton<HomeBloc>(HomeBloc(getIt.get<SupaRepository>()));

    getIt.registerFactory<RegisterBloc>(
      () => RegisterBloc(getIt.get<SupaRepository>()),
    );

    getIt.registerFactory<PlayersBloc>(
      () => PlayersBloc(getIt.get<SupaRepository>()),
    );

    getIt.registerFactory<ManagerPlayerBloc>(
      () => ManagerPlayerBloc(getIt.get<SupaRepository>()),
    );

    getIt.registerFactory<MatchesBloc>(
      () => MatchesBloc(getIt.get<SupaRepository>()),
    );

    getIt.registerFactory<ScoreBloc>(
      () => ScoreBloc(getIt.get<SupaRepository>()),
    );

    return InjectorImpl._(getIt);
  }

  @override
  void dispose() {
    Future.wait([]);
  }
}
