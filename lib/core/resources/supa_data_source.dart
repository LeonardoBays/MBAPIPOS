import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/datasources/remote/supa_client.dart';

abstract class SupaDataSource {
  late final SupaClient _supaClient;

  SupabaseClient get client => _supaClient.client;

  SupaDataSource(SupaClient supaClient) {
    _supaClient = supaClient;
  }
}
