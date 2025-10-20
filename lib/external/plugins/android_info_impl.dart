import 'package:android_id/android_id.dart';

import '../../data/plugins/android_info.dart';

class AndroidInfoImpl implements AndroidInfo {
  @override
  Future<String> getIdDevice() async {
    return await const AndroidId().getId() ?? '';
  }
}
