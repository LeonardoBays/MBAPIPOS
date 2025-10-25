import 'package:get_it/get_it.dart';
import 'package:mbapipos/external/plugins/supa_impl.dart';
import 'package:mbapipos/presentation/screens/home/bloc/home_bloc.dart';
import 'package:mbapipos/presentation/screens/login/bloc/login_bloc.dart';
import 'package:mbapipos/presentation/screens/register/bloc/register_bloc.dart';

import 'data/datasources/local/app_database.dart';
import 'data/datasources/local/shared_data.dart';
import 'data/datasources/remote/supa_client.dart';
import 'data/repositories/remote/supa_repository_impl.dart';
import 'domain/repositories/remote/supa_repository.dart';
import 'external/datasources/local/app_database_impl.dart';
import 'external/datasources/local/shared_data_impl.dart';
import 'external/datasources/remote/supa_client_impl.dart';
import 'presentation/screens/authentication/bloc/authentication_bloc.dart';

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
    getIt.registerSingletonAsync<ApplicationDatabase>(
      ApplicationDatabaseImpl.initialize,
    );

    getIt.registerSingletonAsync<SharedData>(SharedDataImpl.initialize);

    /// API Client--------------------------------------------------------------
    getIt.registerSingleton<SupaClient>(SupaClientImpl(SupaImpl().client));

    /// Preferences Repository--------------------------------------------------

    /// Local Repository--------------------------------------------------------
    // getIt.registerSingleton<UsuAuthLocalRepository>(
    //   UsuAuthLocalRepositoryImpl(
    //     await getIt.getAsync<ApplicationDatabase>(),
    //   ),
    // );

    /// Supabase Repository-------------------------------------------------------
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

    return InjectorImpl._(getIt);
  }

  @override
  void dispose() {
    Future.wait([]);
  }
}
