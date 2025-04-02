import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/core/api/marvel_api.dart';
import 'package:marvel_app/core/api/marvel_api_interceptor.dart';

void main() {
  group('MarvelApi', () {
    test('build() should add MarvelApiInterceptor with correct keys', () {
      const publicKey = '123456';
      const privateKey = 'abcdef';

      final dio = MarvelApi.build(publicKey: publicKey, privateKey: privateKey);

      final interceptors = dio.interceptors;
      final hasInterceptor = interceptors.any((i) => i is MarvelApiInterceptor);
      expect(hasInterceptor, isTrue);

      final interceptor =
          interceptors.firstWhere((i) => i is MarvelApiInterceptor)
              as MarvelApiInterceptor;

      expect(interceptor.publicKey, equals(publicKey));
      expect(interceptor.privateKey, equals(privateKey));
    });

    test('build() should not add multiple interceptors', () {
      final dio = MarvelApi.build(publicKey: '123', privateKey: '456');

      final count = dio.interceptors.whereType<MarvelApiInterceptor>().length;

      expect(count, equals(1));
    });

    test('build() with empty keys still creates Dio (but unsafe)', () {
      final dio = MarvelApi.build(publicKey: '', privateKey: '');

      final interceptor =
          dio.interceptors.firstWhere((i) => i is MarvelApiInterceptor)
              as MarvelApiInterceptor;

      expect(interceptor.publicKey, isEmpty);
      expect(interceptor.privateKey, isEmpty);
    });
  });
}
