import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// import 'package:flutter_localizations/flutter_localizations.dart';

import 'config/routes.dart';
import 'config/theme.dart';
import 'injector.dart';

class MBAPIApp extends StatelessWidget {
  const MBAPIApp({super.key, required this.injector});

  final Injector injector;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MBAPI',
      debugShowCheckedModeBanner: false,
      theme: getDetailedLightThemeGreen(),
      supportedLocales: const [Locale('pt', 'BR')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      onGenerateRoute: (settings) => Routes.router(settings, injector),
    );
  }
}
