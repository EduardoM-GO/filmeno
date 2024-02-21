import 'package:filmeno/app/shared/domain/entities/metadados.dart';
import 'package:filmeno/app/shared/external/mapper/metadados_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/map/filme_map.dart';

void main() {
  late MetadadosMapper mapper;
  setUp(() => mapper = MetadadosMapper());

  test('metadados http mapper - fromMap', () {
    final result = mapper.fromMap(filmeMap);
    expect(result, isA<Metadados>());
    expect(result,
        equals(const Metadados(paginaAtual: 2, quantidadePaginaTotal: 42438)));
  });
}
