import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

Future<Map<String, dynamic>> getDeviceInfo() async {
  final deviceInfoPlugin = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    final info = await deviceInfoPlugin.androidInfo;
    return {
      "deviceModel": info.model,
      "deviceBrand": info.brand,
      "deviceId": info.id,
      "deviceName": info.device,
      "deviceManufacturer": info.manufacturer,
      "deviceProduct": info.product,
      "deviceSerialNumber": "unknown",  
    };
  } else if (Platform.isIOS) {
    final info = await deviceInfoPlugin.iosInfo;
    return {
      "deviceModel": info.utsname.machine,
      "deviceBrand": "Apple",
      "deviceId": info.identifierForVendor ?? "unknown",
      "deviceName": info.name,
      "deviceManufacturer": "Apple",
      "deviceProduct": info.model,
      "deviceSerialNumber": "unknown"
    };
  } else {
    return {
      "deviceModel": "Unknown",
      "deviceBrand": "Unknown",
      "deviceId": "Unknown",
      "deviceName": "Unknown",
      "deviceManufacturer": "Unknown",
      "deviceProduct": "Unknown",
      "deviceSerialNumber": "unknown",
    };
  }
}
