import '../../../core/resources/base_remote_data_source.dart';
import '../../../domain/repositories/remote/api_remote_repository.dart';

class ApiRemoteRepositoryImpl extends BaseRemoteDataSource
    implements ApiRemoteRepository {
  ApiRemoteRepositoryImpl(super.httpClient);
}
