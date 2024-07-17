import 'package:filmeno/app/shared/external/mapper/generos_mapper_mixin.dart';
import 'package:flutter_test/flutter_test.dart';

class _GenerosMapperMixinTest with GenerosMapperMixin {}

void main() {
  late _GenerosMapperMixinTest mixin;

  setUp(() {
    mixin = _GenerosMapperMixinTest();
  });

  group('generos mapper mixin - getGeneros', () {
    test('Deve retornar uma lista vazia', () {
      final result = mixin.getGeneros({});

      expect(result, isEmpty);
    });

    test('Deve retornar uma lista de generos', () {
      final result = mixin.getGeneros({
        'genres': [
          {'name': 'Ação'},
          {'name': 'Comédia'},
        ]
      });

      expect(result, equals(['Ação', 'Comédia']));
    });
  });
}
