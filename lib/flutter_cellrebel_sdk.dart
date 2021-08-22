import 'dart:async';

import 'package:flutter/services.dart';

class CellRebelSDK {
  static const MethodChannel _channel =
      const MethodChannel('flutter_cellrebel_sdk');

  static Future<String?> get getVersion async {
    final String? version = await _channel.invokeMethod('getVersion');
    return version;
  }

  static Future<void> init(String clientId) async {
    _channel.invokeMethod('init', <String, dynamic>{'clientId': clientId});
  }

  static Future<void> startTracking() async {
    _channel.invokeMethod('startTracking');
  }

  static Future<void> stopTracking() async {
    _channel.invokeMethod('stopTracking');
  }

  static Future<bool> clearUserData() async {
    final bool result = await _channel.invokeMethod('clearUserData');
    return result;
  }
}
