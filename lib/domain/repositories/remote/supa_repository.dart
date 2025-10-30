import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../data/models/match.dart';
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

  Future<List<Match>> loadMatches(String id);

  Future<void> insertMatch({
    required DateTime startAt,
    required DateTime endAt,
    required String homeTeamName,
    required String awayTeamName,
    required String createdBy,
  });

  Future<void> deleteMatch({required String id});

  Future<void> updateMatch({
    required String id,
    required DateTime startAt,
    required DateTime endAt,
    required String homeTeamName,
    required String awayTeamName,
    required String createdBy,
  });

  Future<Match?> loadMatchById(String id);

  Future<void> updateMatchHomeScore(String id, int score);

  Future<void> updateMatchAwayScore(String id, int score);
}
