import '../../data/models/app_info.dart';
import '../../data/plugins/android_info.dart';
import '../../data/plugins/app_package_info.dart';
import '../../data/plugins/device_hardware_info.dart';

class AppSystemInfo {
  static AppSystemInfo? _instance;

  static Future<AppSystemInfo> initialize({
    required DeviceHardwareInfo deviceHardwareInfo,
    required AppPackageInfo appPackageInfo,
    required AndroidInfo androidInfo,
  }) async =>
      _instance ??= AppSystemInfo._(
        await _initialize(
          deviceHardwareInfo: deviceHardwareInfo,
          appPackageInfo: appPackageInfo,
          androidInfo: androidInfo,
        ),
      );

  AppSystemInfo._(this._appInfo);

  static Future<AppInfo> _initialize({
    required DeviceHardwareInfo deviceHardwareInfo,
    required AppPackageInfo appPackageInfo,
    required AndroidInfo androidInfo,
  }) async {
    final List<dynamic> info = await Future.wait([
      deviceHardwareInfo.getBrand(),
      deviceHardwareInfo.getHardware(),
      androidInfo.getIdDevice(),
      deviceHardwareInfo.getManufacturer(),
      deviceHardwareInfo.getModel(),
      deviceHardwareInfo.getOperationalSystem(),
      appPackageInfo.getAppVersion(),
      appPackageInfo.getAppVersionCode(),
      deviceHardwareInfo.getApiLevel(),
    ]);

    return AppInfo(
      deviceInfo: DeviceInfo(
        brand: info[0],
        hardware: info[1],
        deviceId: info[2],
        manufactured: info[3],
        model: info[4],
        operationalSystem: info[5],
        sdkInt: info[8],
      ),
      appVersionInfo: AppVersionInfo(
        appVersionName: info[6],
        appVersionCode: info[7],
      ),
    );
  }

  late final AppInfo _appInfo;

  static AppInfo? get appInfo => _instance?._appInfo;
}
