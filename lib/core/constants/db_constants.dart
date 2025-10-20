class DatabaseConstants {
  //Database configurations
  static const int version = 1;
  static const String path = 'assets/sql';
  static const String dbName = 'mbapipos.db';
  static const String create = '$path/create.sql';
  static const String pathUpgrade = '$path/upgrade/script_upgrade_';
}

enum TableName {
  table('table');

  final String value;

  const TableName(this.value);
}
