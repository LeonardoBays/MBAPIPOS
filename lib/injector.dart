import 'package:get_it/get_it.dart';

import 'core/shared/app_system_info.dart';
import 'data/datasources/local/app_database.dart';
import 'data/datasources/local/shared_data.dart';
import 'data/datasources/remote/http_client.dart';
import 'data/repositories/preferences/preferences_local_repository_impl.dart';
import 'data/repositories/remote/api_remote_repository_impl.dart';
import 'domain/controller/authentication_controller.dart';
import 'domain/controller/preferences_controller.dart';
import 'domain/repositories/preferenfeces/preferences_local_repository.dart';
import 'domain/repositories/remote/api_remote_repository.dart';
import 'external/datasources/local/app_database_impl.dart';
import 'external/datasources/local/shared_data_impl.dart';
import 'external/datasources/remote/http_client_impl.dart';
import 'external/plugins/android_info_impl.dart';
import 'external/plugins/app_package_impl.dart';
import 'external/plugins/device_hardware_info_impl.dart';
import 'presentation/screens/authentication/authentication_bloc/authentication_bloc.dart';

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

    /// Plugins
    await AppSystemInfo.initialize(
      deviceHardwareInfo: DeviceHardwareInfoImpl(),
      appPackageInfo: AppPackageInfoImpl(),
      androidInfo: AndroidInfoImpl(),
    );

    /// Database----------------------------------------------------------------
    getIt.registerSingletonAsync<ApplicationDatabase>(
      ApplicationDatabaseImpl.initialize,
    );

    getIt.registerSingletonAsync<SharedData>(SharedDataImpl.initialize);

    /// API Client--------------------------------------------------------------
    getIt.registerSingleton<HttpClient>(HttpClientImpl());

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

    /// Remote Repository-------------------------------------------------------
    getIt.registerSingleton<ApiRemoteRepository>(
      ApiRemoteRepositoryImpl(getIt.get<HttpClient>()),
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

    return InjectorImpl._(getIt);
  }

  @override
  void dispose() {
    Future.wait([]);
  }
}
