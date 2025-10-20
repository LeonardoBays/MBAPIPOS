class AppInfo {
  final DeviceInfo deviceInfo;
  final AppVersionInfo appVersionInfo;

  AppInfo({
    required this.deviceInfo,
    required this.appVersionInfo,
  });

  @override
  String toString() => 'AppInfo{'
      'deviceInfo: $deviceInfo, '
      'appInfo: $appVersionInfo'
      '}';
}

class DeviceInfo {
  final String brand;
  final String hardware;
  final String deviceId;
  final String manufactured;
  final String model;
  final String operationalSystem;
  final int sdkInt;

  DeviceInfo({
    required this.brand,
    required this.hardware,
    required this.deviceId,
    required this.manufactured,
    required this.model,
    required this.operationalSystem,
    required this.sdkInt,
  });

  @override
  String toString() => 'DeviceInfo{'
      'brand: $brand, '
      'hardware: $hardware, '
      'deviceId: $deviceId, '
      'manufactured: $manufactured, '
      'model: $model, '
      'operationalSystem: $operationalSystem'
      'sdkInt: $sdkInt'
      '}';
}

class AppVersionInfo {
  final String appVersionName;
  final String appVersionCode;

  AppVersionInfo({required this.appVersionName, required this.appVersionCode});

  @override
  String toString() => 'AppVersionInfo{'
      'appVersionName: $appVersionName, '
      'appVersionCode: $appVersionCode'
      '}';
}
