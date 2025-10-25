import 'package:supabase_flutter/supabase_flutter.dart';

abstract class Supa {
  Future<void> initialize();

  SupabaseClient get client;
}
