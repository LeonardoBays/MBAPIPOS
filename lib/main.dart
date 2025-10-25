import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'app.dart';
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

Future<void> _loadEssentialData(Injector injector) async {}
