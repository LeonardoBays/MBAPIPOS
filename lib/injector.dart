import 'package:get_it/get_it.dart';
import 'package:mbapipos/external/plugins/supa_impl.dart';
import 'package:mbapipos/presentation/screens/login/bloc/login_bloc.dart';

import 'data/datasources/local/app_database.dart';
import 'data/datasources/local/shared_data.dart';
import 'data/datasources/remote/supa_client.dart';
import 'data/repositories/preferences/preferences_local_repository_impl.dart';
import 'data/repositories/remote/supa_repository_impl.dart';
import 'domain/controller/authentication_controller.dart';
import 'domain/controller/preferences_controller.dart';
import 'domain/repositories/preferenfeces/preferences_local_repository.dart';
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
    getIt.registerSingleton<PreferencesLocalRepository>(
      PreferencesLocalRepositoryImpl(await getIt.getAsync<SharedData>()),
    );

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
    getIt.registerSingleton<PreferencesController>(
      PreferencesController(getIt<PreferencesLocalRepository>()),
    );

    getIt.registerSingleton<AuthenticationController>(
      AuthenticationController(),
    );

    /// BLoC--------------------------------------------------------------------
    getIt.registerSingleton<AuthenticationBloc>(
      AuthenticationBloc(
        getIt.get<AuthenticationController>(),
        getIt.get<PreferencesController>(),
      ),
    );

    getIt.registerSingleton<LoginBloc>(LoginBloc(getIt.get<SupaRepository>()));

    return InjectorImpl._(getIt);
  }

  @override
  void dispose() {
    Future.wait([]);
  }
}
