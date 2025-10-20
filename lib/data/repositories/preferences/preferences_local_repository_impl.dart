import '../../../domain/repositories/preferenfeces/preferences_local_repository.dart';
import '../../datasources/local/shared_data.dart';

class PreferencesLocalRepositoryImpl extends PreferencesLocalRepository {
  PreferencesLocalRepositoryImpl(this._sharedData);

  final SharedData _sharedData;
}
