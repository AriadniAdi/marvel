import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/domain/entities/hero_model.dart';

void main() {
  group('HeroModel.fromMap', () {
    test('should create HeroModel with valid data', () {
      final map = {
        'id': 1,
        'name': 'foo',
        'description': 'bar',
        'thumbnail': {'path': 'http://image', 'extension': 'jpg'},
      };

      final hero = HeroModel.fromMap(map);

      expect(hero.id, 1);
      expect(hero.name, 'foo');
      expect(hero.description, 'bar');
      expect(hero.imageUrl, 'http://image.jpg');
    });

    test('should use default values when fields are missing', () {
      final map = {
        'thumbnail': {'path': 'http://img', 'extension': 'png'},
      };

      final hero = HeroModel.fromMap(map);

      expect(hero.id, 0);
      expect(hero.name, 'No name');
      expect(hero.description, 'Not have description');
      expect(hero.imageUrl, 'http://img.png');
    });

    test('should use default description if it is an empty string', () {
      final map = {
        'id': 2,
        'name': 'foo',
        'description': '   ',
        'thumbnail': {'path': 'http://foo', 'extension': 'png'},
      };

      final hero = HeroModel.fromMap(map);

      expect(hero.description, 'Not have description');
    });
  });
}
