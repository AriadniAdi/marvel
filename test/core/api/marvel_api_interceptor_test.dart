import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/core/api/marvel_api_interceptor.dart';
import 'package:dio/dio.dart';
// ignore: depend_on_referenced_packages
import 'package:crypto/crypto.dart';
import 'dart:convert';

void main() {
  test('When MarveApiInterceptor add ts, apikey  hash with success', () {
    const publicKey = '123456';
    const privateKey = 'abcdef';

    final interceptor = MarvelApiInterceptor(
      publicKey: publicKey,
      privateKey: privateKey,
    );

    final options = RequestOptions(path: '/characters');

    interceptor.onRequest(options, RequestInterceptorHandler());

    expect(options.queryParameters.containsKey('ts'), isTrue);
    expect(options.queryParameters['apikey'], equals(publicKey));

    final ts = options.queryParameters['ts'];
    final expectedHash =
        md5.convert(utf8.encode(ts + privateKey + publicKey)).toString();

    expect(options.queryParameters['hash'], equals(expectedHash));
  });

  test(
    'When MarvelApiInterceptor receives empty keys, it still adds parameters (but hash will be for empty input)',
    () {
      const publicKey = '';
      const privateKey = '';

      final interceptor = MarvelApiInterceptor(
        publicKey: publicKey,
        privateKey: privateKey,
      );

      final options = RequestOptions(path: '/characters');

      interceptor.onRequest(options, RequestInterceptorHandler());

      expect(options.queryParameters.containsKey('ts'), isTrue);
      expect(options.queryParameters['apikey'], equals(publicKey));

      final ts = options.queryParameters['ts'];
      final expectedHash = md5.convert(utf8.encode(ts)).toString();
      expect(options.queryParameters['hash'], equals(expectedHash));
    },
  );
}
