import 'package:marvel_app/data/marvel_data_source.dart';
import 'package:marvel_app/domain/entities/hero_model.dart';

class GetHeroDetailUseCase {
  final MarvelDatasource datasource;

  GetHeroDetailUseCase(this.datasource);

  Future<HeroModel> call(int id) async {
    return await datasource.getHeroDetail(id);
  }
}
