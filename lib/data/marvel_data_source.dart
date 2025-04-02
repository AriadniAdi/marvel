import 'package:dio/dio.dart';
import 'package:marvel_app/domain/entities/hero_model.dart';

class MarvelDatasource {
  final Dio dio;
  MarvelDatasource(this.dio);

  Future<HeroModel> getHeroDetail(int id) async {
    final response = await dio.get(
      'https://gateway.marvel.com/v1/public/characters/$id',
    );
    final data = response.data['data']['results'][0];

    return HeroModel.fromMap(data);
  }

  Future<List<HeroModel>> getHeroes({int limit = 20, int offset = 0}) async {
    final response = await dio.get(
      'https://gateway.marvel.com/v1/public/characters',
      queryParameters: {'limit': limit, 'offset': offset},
    );
    final results = List<Map<String, dynamic>>.from(
      response.data['data']['results'],
    );
    return results.map((e) => HeroModel.fromMap(e)).toList();
  }
}
