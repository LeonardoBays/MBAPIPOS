import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SupaClient {
  final SupabaseClient client;

  const SupaClient(this.client);
}
