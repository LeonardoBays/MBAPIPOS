import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/plugins/supa.dart';
import '../../env.dart';

final class SupaImpl extends Supa {
  @override
  SupabaseClient get client => Supabase.instance.client;

  @override
  Future<void> initialize() async {
    await Supabase.initialize(url: Env.url, anonKey: Env.anonKey);
  }
}
