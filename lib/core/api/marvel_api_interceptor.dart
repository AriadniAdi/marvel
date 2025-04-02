import 'package:dio/dio.dart';

// ignore: library_prefixes
import 'package:marvel_app/core/constants.dart' as AppKeys;

// ignore: depend_on_referenced_packages
import 'package:crypto/crypto.dart';
import 'dart:convert';

class MarvelAuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final ts = DateTime.now().millisecondsSinceEpoch.toString();
    final publicKey = AppKeys.marvelPublicKey;
    final privateKey = AppKeys.marvelPrivateKey;
    final hashInput = ts + privateKey + publicKey;
    final hash = md5.convert(utf8.encode(hashInput)).toString();

    options.queryParameters.addAll({
      'ts': ts,
      'apikey': publicKey,
      'hash': hash,
    });

    super.onRequest(options, handler);
  }
}
