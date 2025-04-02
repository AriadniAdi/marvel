import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class AnalyticsChannel {
  static const MethodChannel _channel = MethodChannel('analytics_channel');

  static Future<void> logEvent(String name, Map<String, dynamic> params) async {
    try {
      await _channel.invokeMethod('logEvent', {'name': name, 'params': params});
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao enviar evento: $e');
      }
    }
  }
}
