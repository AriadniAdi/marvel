import 'package:dio/dio.dart';
import 'package:marvel_app/core/api/marvel_api_interceptor.dart';

class MarvelApi {
  static final Dio dio = Dio()..interceptors.add(MarvelAuthInterceptor());
}
