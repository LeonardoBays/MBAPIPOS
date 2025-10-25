import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SupaRepository {
  Future<AuthResponse> auth({required String email, required String password});
}
