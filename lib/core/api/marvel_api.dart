import 'package:dio/dio.dart';
import 'package:marvel_app/core/api/marvel_api_interceptor.dart';
import 'package:marvel_app/core/keys/app_keys.dart';

class MarvelApi {
  static final Dio dio = MarvelApi.build(
    publicKey: AppKeys.marvelPublicKey,
    privateKey: AppKeys.marvelPrivateKey,
  );

  static Dio build({required String publicKey, required String privateKey}) {
    return Dio()
      ..interceptors.add(
        MarvelApiInterceptor(publicKey: publicKey, privateKey: privateKey),
      );
  }
}
