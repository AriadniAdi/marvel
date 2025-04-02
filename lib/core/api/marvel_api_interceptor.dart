import 'package:dio/dio.dart';

// ignore: depend_on_referenced_packages
import 'package:crypto/crypto.dart';
import 'dart:convert';

class MarvelApiInterceptor extends Interceptor {
  final String publicKey;
  final String privateKey;

  MarvelApiInterceptor({required this.publicKey, required this.privateKey});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final ts = DateTime.now().millisecondsSinceEpoch.toString();
    final hash =
        md5.convert(utf8.encode(ts + privateKey + publicKey)).toString();

    options.queryParameters.addAll({
      'ts': ts,
      'apikey': publicKey,
      'hash': hash,
    });

    super.onRequest(options, handler);
  }
}
