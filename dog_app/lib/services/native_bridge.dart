import 'package:flutter/services.dart';

class NativeBridge {
  static const platform = const MethodChannel('com.example/native_bridge');

  static Future<String> getPlatformVersion() async {
    try {
      return await platform.invokeMethod('getPlatformVersion');
    } catch (e) {
      print('Error: $e');
      return "Error";
    }
  }
}