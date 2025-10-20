import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/enum/preferences.dart';

abstract class SharedData {
  /// Limpa todos os valores armazenados no plugin
  Future<void> clearValues();

  /// Busca um valor armazenado pela chave,
  /// caso não encontre é retornado [null],
  /// - Type retornados: String?, List&lt;String&gt;?, int?, double? e bool?
  T? getValue<T>(Preferences preference);

  /// Salva valores de chave e valor utilizando a lib [SharedPreferences],
  /// type armazenados : String, List&lt;String&gt;, int, double e bool,
  /// outros tipos não são armazenados pelo plugin.
  /// * [key] chave utilizada para referenciar o valor;
  /// * [value] valor guardado pela chave.
  Future<void> setValue<T>(Preferences preference, T value);

  Future<void> cleanValue(Preferences preference);
}
