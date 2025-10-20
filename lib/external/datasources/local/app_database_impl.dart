import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/constants/db_constants.dart';
import '../../../data/datasources/local/app_database.dart';

class ApplicationDatabaseImpl implements ApplicationDatabase {
  static ApplicationDatabaseImpl? _instance;

  static Future<ApplicationDatabaseImpl> initialize() async =>
      _instance ??= ApplicationDatabaseImpl._(await _initialize());

  ApplicationDatabaseImpl._(Database database) : db = database;

  @override
  Database db;

  @override
  Future<String> getDbPath() async => await getDatabasesPath();

  static Future<Database> _initialize() async {
    late String databasesPath;

    if (Platform.isWindows) {
      // sqfliteFfiInit();
      // databaseFactory = databaseFactoryFfi;
      databasesPath = await getDatabasesPath();
    } else {
      databasesPath = await getDatabasesPath();
    }

    String path = join(databasesPath, DatabaseConstants.dbName);

    var db = await openDatabase(
      path,
      version: DatabaseConstants.version,
      onCreate: _onCreate,
    );
    return db;
  }

  static void _onCreate(Database db, int newVersion) async {
    try {
      String s = await rootBundle.loadString(DatabaseConstants.create);

      List<String> sqls = s.split(';');

      for (String sql in sqls) {
        if (sql.trim().isNotEmpty) {
          await db.execute(sql);
        }
      }
    } catch(e) {
      log("CATCH _ONCREATE DATABASE: $e");
    }
  }
}
