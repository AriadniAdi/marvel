import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/core/usecases/get_hero_detail_usecase.dart';
import 'package:marvel_app/data/marvel_data_source.dart';
import 'package:marvel_app/domain/entities/hero_model.dart';
import 'package:mocktail/mocktail.dart';

class MockMarvelDatasource extends Mock implements MarvelDatasource {}

void main() {
  late GetHeroDetailUseCase useCase;
  late MockMarvelDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockMarvelDatasource();
    useCase = GetHeroDetailUseCase(mockDatasource);
  });

  test(
    'should return HeroModel when datasource returns successfully',
    () async {
      const heroId = 101;
      final mockHero = HeroModel(
        id: heroId,
        name: 'Homem de Ferro',
        description: 'Gênio, bilionário, etc.',
        imageUrl: 'image',
      );

      when(
        () => mockDatasource.getHeroDetail(heroId),
      ).thenAnswer((_) async => mockHero);

      final result = await useCase(heroId);

      expect(result, equals(mockHero));
      verify(() => mockDatasource.getHeroDetail(heroId)).called(1);
    },
  );

  test('should throw exception when datasource throws', () async {
    const heroId = 404;
    when(
      () => mockDatasource.getHeroDetail(heroId),
    ).thenThrow(Exception('Herói não encontrado'));

    expect(() => useCase(heroId), throwsException);
    verify(() => mockDatasource.getHeroDetail(heroId)).called(1);
  });
}
