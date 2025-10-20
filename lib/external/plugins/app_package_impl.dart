import 'package:package_info_plus/package_info_plus.dart';

import '../../data/plugins/app_package_info.dart';

class AppPackageInfoImpl implements AppPackageInfo {
  @override
  Future<String> getAppVersion() async {
    return await PackageInfo.fromPlatform().then((value) => value.version);
  }

  @override
  Future<String> getAppVersionCode() async {
    return await PackageInfo.fromPlatform().then((value) => value.buildNumber);
  }
}
