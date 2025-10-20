import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

import '../../../data/plugins/device_hardware_info.dart';

class DeviceHardwareInfoImpl implements DeviceHardwareInfo {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  @override
  Future<String> getBrand() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
      return androidInfo.brand;
    } else if (Platform.isIOS) {
      return 'APPLE';
    }
    return '0';
  }

  @override
  Future<String> getHardware() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
      return androidInfo.hardware;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
      return iosInfo.utsname.machine;
    }
    return '0';
  }

  @override
  Future<String> getManufacturer() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
      return androidInfo.manufacturer;
    } else if (Platform.isIOS) {
      return 'Apple';
    }
    return '0';
  }

  @override
  Future<String> getModel() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
      return androidInfo.model;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
      return iosInfo.model;
    }
    return '0';
  }

  @override
  Future<String> getOperationalSystem() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
      return 'ANDROID_${androidInfo.version.release}';
    } else if (Platform.isIOS) {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      return 'IOS_${iosInfo.systemVersion}';
    }
    return '0';
  }

  @override
  Future<int> getApiLevel() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
      return androidInfo.version.sdkInt;
    }

    return 0;
  }
}
