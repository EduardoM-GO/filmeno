import 'package:filmeno/app/shared/domain/entities/metadados_http.dart';
import 'package:filmeno/app/shared/external/mapper/metadados_http_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/map/filme_map.dart';

void main() {
  late MetadadosHttpMapper mapper;
  setUp(() => mapper = MetadadosHttpMapper());

  test('metadados http mapper - fromMap', () {
    final result = mapper.fromMap(filmeMap);
    expect(result, isA<MetadadosHttp>());
    expect(
        result,
        equals(
            const MetadadosHttp(paginaAtual: 2, quantidadePaginaTotal: 42438)));
  });
}
