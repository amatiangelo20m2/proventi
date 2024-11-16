import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

Future<String> checkDeviceType() async {
  final deviceInfoPlugin = DeviceInfoPlugin();

  if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
    String deviceType = iosInfo.model ?? 'Unknown Device';

    if (deviceType.toLowerCase().contains('ipad')) {
      return 'iPad';
    } else if (deviceType.toLowerCase().contains('iphone')) {
      return 'iPhone';
    }
  }
  return 'Unknown';
}