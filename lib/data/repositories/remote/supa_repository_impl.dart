import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/resources/supa_data_source.dart';
import '../../../domain/repositories/remote/supa_repository.dart';
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
  Future<List<Player>> loadPlayers(String uuid) async {
    final players = await client
        .from('players')
        .select()
        .eq('created_by', uuid)
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
}
