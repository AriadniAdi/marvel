import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:marvel_app/core/api/marvel_api_interceptor.dart';
import 'package:marvel_app/core/keys/app_keys.dart';
import 'package:marvel_app/core/usecases/get_hero_detail_usecase.dart';
import 'package:marvel_app/data/marvel_data_source.dart';

final sl = GetIt.instance;

void setupLocator() {
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio();
    dio.interceptors.add(
      MarvelApiInterceptor(
        publicKey: AppKeys.marvelPublicKey,
        privateKey: AppKeys.marvelPrivateKey,
      ),
    );
    return dio;
  });

  sl.registerLazySingleton<MarvelDatasource>(() => MarvelDatasource(sl()));
  sl.registerLazySingleton<GetHeroDetailUseCase>(
    () => GetHeroDetailUseCase(sl()),
  );
}
