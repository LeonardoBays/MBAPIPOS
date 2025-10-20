abstract class AppPackageInfo {
  /// Retorna o versionName do aplicativo
  Future<String> getAppVersion();

  /// Retorna o versionCode do aplicativo
  Future<String> getAppVersionCode();
}