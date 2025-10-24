import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/shared/app_system_info.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  void initState() {
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      final Session? session = data.session;

      if (event == AuthChangeEvent.initialSession || event == AuthChangeEvent.signedIn) {
        if (session != null) {
          print('tem usuario');
        } else {
          print('nao tem usuario');
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            ElevatedButton(onPressed: _create, child: Text('Create user')),
            ElevatedButton(onPressed: _login, child: Text('Login user')),

            Text(
              "${AppSystemInfo.appInfo?.appVersionInfo.appVersionName} - "
              "${AppSystemInfo.appInfo?.appVersionInfo.appVersionCode}",
            ),
          ],
        ),
      ),
    );
  }

  void _create() async {
    final supabase = Supabase.instance.client;

    final AuthResponse response = await supabase.auth.signUp(
      email: 'startmater@gmail.com',
      password: 'bochatop',
      data: {'name': 'Leonardo Bays'},
    );

    print('response.session: ${response.session}');
    print('response.user: ${response.user}');
  }

  void _login() async {
    final supabase = Supabase.instance.client;

    final AuthResponse response = await supabase.auth.signInWithPassword(
      email: 'startmater@gmail.com',
      password: 'bochatop',
    );

    print('response.session: ${response.session}');
    print('response.user: ${response.user}');
  }
}
