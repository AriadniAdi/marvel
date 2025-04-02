import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:marvel_app/core/api/marvel_api_interceptor.dart';
import 'package:marvel_app/core/injector.dart';
import 'package:marvel_app/core/keys/app_keys.dart';
import 'package:marvel_app/core/usecases/get_hero_detail_usecase.dart';
import 'package:marvel_app/data/marvel_data_source.dart';

void main() {
  final sl = GetIt.instance;

  setUp(() {
    sl.reset(); // limpa todos os registros anteriores
    setupLocator(); // registra novamente
  });

  test('should register Dio with MarvelApiInterceptor', () {
    final dio = sl<Dio>();

    expect(dio, isA<Dio>());

    final hasInterceptor = dio.interceptors.any(
      (i) => i is MarvelApiInterceptor,
    );

    expect(hasInterceptor, isTrue);

    final interceptor =
        dio.interceptors.firstWhere((i) => i is MarvelApiInterceptor)
            as MarvelApiInterceptor;

    expect(interceptor.publicKey, equals(AppKeys.marvelPublicKey));
    expect(interceptor.privateKey, equals(AppKeys.marvelPrivateKey));
  });

  test('should register MarvelDatasource', () {
    final datasource = sl<MarvelDatasource>();
    expect(datasource, isA<MarvelDatasource>());
  });

  test('should register GetHeroDetailUseCase', () {
    final useCase = sl<GetHeroDetailUseCase>();
    expect(useCase, isA<GetHeroDetailUseCase>());
  });
}
