import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';
import 'env.dart';
import 'injector.dart';

void main() async {
  final Injector injector = await _initializeApp();

  runApp(MBAPIApp(injector: injector));
}

Future<Injector> _initializeApp() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final Injector injector = await InjectorImpl.initializeDependencies();
  await _loadEssentialData(injector);
  return injector;
}

Future<void> _loadEssentialData(Injector injector) async {

}
