import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/resources/supa_data_source.dart';
import '../../../domain/repositories/remote/supa_repository.dart';

class SupaRepositoryImpl extends SupaDataSource implements SupaRepository {
  SupaRepositoryImpl(super.httpClient);

  @override
  Future<AuthResponse> auth({
    required String email,
    required String password,
  }) async {
    return await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }
}
