import 'dart:async';

import 'package:sqflite/sqflite.dart';

import '../../data/datasources/local/app_database.dart';
import 'base_model.dart';

abstract class BaseLocalDataSource<T extends BaseModel> {
  final ApplicationDatabase _applicationDatabase;

  final String _tableName;

  final Function _fromMap;

  BaseLocalDataSource(
    this._applicationDatabase,
    this._tableName,
    this._fromMap,
  );

  Future<int> insert(T model) async => await _applicationDatabase.db.insert(
        _tableName,
        model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

  Future<void> insertAll(List<T> list) async {
    final Batch batch = _applicationDatabase.db.batch();

    for (T element in list) {
      batch.insert(
        _tableName,
        element.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  Future<int> delete({String? where, List<Object?>? whereArgs}) async =>
      await _applicationDatabase.db
          .delete(_tableName, where: where, whereArgs: whereArgs);

  Future<List<T>> findAll() async => await _applicationDatabase.db
      .query(_tableName)
      .then((value) => value.map<T>((e) => _fromMap(e)).toList());

  Future<T?> findById({String? where, List<Object?>? whereArgs}) async =>
      await _applicationDatabase.db
          .query(_tableName, where: where, whereArgs: whereArgs)
          .then((value) => value.isNotEmpty ? _fromMap(value.first) : null);

  Future<List<T>> query(String sql, [List<dynamic>? arguments]) async {
    final list = await _applicationDatabase.db.rawQuery(sql, arguments);
    return list.map<T>((json) => _fromMap(json)).toList();
  }

  Future<bool> exists({String? where, List<Object?>? whereArgs}) async =>
      await _applicationDatabase.db
          .query(_tableName, where: where, whereArgs: whereArgs)
          .then((value) => value.isNotEmpty);

  Future<int?> count({String where = ''}) async {
    final List<Map<String, Object?>> list = await _applicationDatabase.db
        .rawQuery('select count(*) from $_tableName $where');
    return Sqflite.firstIntValue(list);
  }

  Future<int?> rawFindId(String query) async {
    final list = await _applicationDatabase.db.rawQuery(query);
    return Sqflite.firstIntValue(list);
  }

  Future<int?> rawCount(String query) async {
    final List<Map<String, Object?>> list =
        await _applicationDatabase.db.rawQuery(query);
    return Sqflite.firstIntValue(list);
  }

  Future<int> deleteAll() async =>
      await _applicationDatabase.db.rawDelete('delete from $_tableName');

  Future<int> update(
    int id,
    valor,
    String colunaUpdate,
    String campoControle,
  ) async =>
      await _applicationDatabase.db.rawUpdate(
        'update $_tableName set '
        "$colunaUpdate = '$valor' where $campoControle = ?",
        [id],
      );

  Future<int> rawUpdate(String query, [List<Object?>? arguments]) async =>
      await _applicationDatabase.db.rawUpdate(query, arguments);

  Future<int> rawDelete(String query, [List<Object?>? arguments]) async =>
      await _applicationDatabase.db.rawDelete(query, arguments);

  Future<int> deleteById(int id, String campo) async =>
      await _applicationDatabase.db
          .rawDelete('delete from $_tableName where $campo = ?', [id]);
}
