import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants/enum/match_team.dart';
import '../../../core/resources/supa_data_source.dart';
import '../../../domain/repositories/remote/supa_repository.dart';
import '../../models/match.dart';
import '../../models/player.dart';

class SupaRepositoryImpl extends SupaDataSource implements SupaRepository {
  SupaRepositoryImpl(super.httpClient);

  @override
  User? getUser() => client.auth.currentUser;

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

  @override
  Future<void> logout() async {
    await client.auth.signOut();
  }

  @override
  Future<AuthResponse> signUp({
    required String email,
    required String password,
  }) async {
    return await client.auth.signUp(email: email, password: password);
  }

  @override
  Future<List<Player>> loadPlayers(String id) async {
    final players = await client
        .from('players')
        .select()
        .eq('created_by', id)
        .isFilter('deleted_at', null)
        .order('name', ascending: true);

    return players.map<Player>((e) => Player.fromMap(e)).toList();
  }

  @override
  Future<void> insertPlayer({
    required String name,
    required String createdBy,
  }) async {
    await client.from('players').insert({
      'name': name,
      'created_by': createdBy,
    });
  }

  @override
  Future<void> deletePlayer({required String id}) async {
    await client.from('players').update({'deleted_at': 'now()'}).eq('id', id);
  }

  @override
  Future<void> updatePlayer({required String name, required String id}) async {
    await client.from('players').update({'name': name}).eq('id', id);
  }

  @override
  Future<Player?> loadPlayerById(String id) async {
    final player = await client.from('players').select().eq('id', id).single();

    return Player.fromMap(player);
  }

  @override
  Future<List<Match>> loadMatches(String id) async {
    final matches = await client.rpc('get_matches', params: {"created_by": id});

    return matches.map<Match>((e) => Match.fromMap(e)).toList();
  }

  @override
  Future<void> insertMatch({
    required DateTime startAt,
    required DateTime endAt,
    required String homeTeamName,
    required String awayTeamName,
    required String createdBy,
  }) async {
    await client.from('match').insert({
      'start_at': startAt.toIso8601String().replaceAll('T', ' '),
      'end_at': endAt.toIso8601String().replaceAll('T', ' '),
      'home_team_name': homeTeamName,
      'away_team_name': awayTeamName,
      'created_by': createdBy,
    });
  }

  @override
  Future<void> deleteMatch({required String id}) async {
    await client.from('match').update({'deleted_at': 'now()'}).eq('id', id);
  }

  @override
  Future<void> updateMatch({
    required String id,
    required DateTime startAt,
    required DateTime endAt,
    required String homeTeamName,
    required String awayTeamName,
    required String createdBy,
  }) async {
    await client
        .from('match')
        .update({
          'start_at': startAt.toIso8601String().replaceAll('T', ' '),
          'end_at': endAt.toIso8601String().replaceAll('T', ' '),
          'home_team_name': homeTeamName,
          'away_team_name': awayTeamName,
          'created_by': createdBy,
        })
        .eq('id', id);
  }

  @override
  Future<Match?> loadMatchById(String id) async {
    final player = await client.from('match').select().eq('id', id).single();

    return Match.fromMap(player);
  }

  @override
  Future<void> updateMatchHomeScore(String id, int score) async {
    await client.from('match').update({'home_score': score}).eq('id', id);
  }

  @override
  Future<void> updateMatchAwayScore(String id, int score) async {
    await client.from('match').update({'away_score': score}).eq('id', id);
  }

  @override
  Future<List<Player>> loadPlayersByMatch(
    String id,
    MatchTeam matchTeam,
  ) async {
    final players = await client
        .from('match_player')
        .select('player (*)')
        .eq('match_id', id)
        .eq('team_played', matchTeam.value);

    return players.map<Player>((e) => Player.fromMap(e)).toList();
  }
}
