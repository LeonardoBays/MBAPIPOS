import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../data/models/player.dart';

abstract class SupaRepository {
  User? getUser();

  Future<AuthResponse> auth({required String email, required String password});

  Future<AuthResponse> signUp({
    required String email,
    required String password,
  });

  Future<void> logout();

  Future<List<Player>> loadPlayers(String uuid);

  Future<void> insertPlayer({required String name, required String createdBy});

  Future<void> deletePlayer({required String id});

  Future<void> updatePlayer({required String name, required String id});

  Future<Player?> loadPlayerById(String id);
}
