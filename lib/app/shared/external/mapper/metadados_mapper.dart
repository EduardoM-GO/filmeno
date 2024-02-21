import 'package:filmeno/app/shared/domain/entities/metadados.dart';
import 'package:filmeno/app/shared/external/mapper/mapper.dart';

class MetadadosMapper implements Mapper<Metadados> {
  @override
  Metadados fromMap(Map<String, dynamic> map) => Metadados(
        paginaAtual: map['page'] as int? ?? 0,
        quantidadePaginaTotal: map['total_pages'] as int? ?? 0,
      );
}
