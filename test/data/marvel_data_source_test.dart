import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/data/marvel_data_source.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

class MockResponse extends Mock implements Response {}

void main() {
  late MarvelDatasource datasource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    datasource = MarvelDatasource(mockDio);
  });

  group('getHeroDetail', () {
    test('should return HeroModel on successful response', () async {
      const id = 101;
      final mockData = {
        'data': {
          'results': [
            {
              'id': id,
              'name': 'foo bar',
              'description': 'foo bar',
              'thumbnail': {'path': 'http://image', 'extension': 'jpg'},
            },
          ],
        },
      };

      when(() => mockDio.get(any())).thenAnswer(
        (_) async => Response(
          data: mockData,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final hero = await datasource.getHeroDetail(id);

      expect(hero.id, id);
      expect(hero.name, 'foo bar');
      expect(hero.imageUrl, 'http://image.jpg');
    });

    test('should throw exception on Dio error', () async {
      when(() => mockDio.get(any())).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 404,
            requestOptions: RequestOptions(path: ''),
          ),
        ),
      );

      expect(() => datasource.getHeroDetail(999), throwsException);
    });
  });

  group('getHeroes', () {
    test('should return list of HeroModel on success', () async {
      final mockData = {
        'data': {
          'results': [
            {
              'id': 1,
              'name': 'foo bar',
              'description': 'foo bar',
              'thumbnail': {'path': 'http://iron', 'extension': 'png'},
            },
            {
              'id': 2,
              'name': 'foo bar',
              'description': 'foo bar',
              'thumbnail': {'path': 'http://thor', 'extension': 'jpg'},
            },
          ],
        },
      };

      when(
        () =>
            mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer(
        (_) async => Response(
          data: mockData,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final heroes = await datasource.getHeroes();

      expect(heroes.length, 2);
      expect(heroes.first.name, 'foo bar');
      expect(heroes.last.name, 'bar');
    });

    test('should throw exception on Dio failure', () async {
      when(
        () =>
            mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          type: DioExceptionType.connectionTimeout,
        ),
      );

      expect(() => datasource.getHeroes(), throwsException);
    });
  });
}
