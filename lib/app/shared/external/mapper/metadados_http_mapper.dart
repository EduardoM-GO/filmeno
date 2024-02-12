import 'package:filmeno/app/shared/domain/entities/metadados_http.dart';
import 'package:filmeno/app/shared/external/mapper/mapper.dart';

class MetadadosHttpMapper implements Mapper<MetadadosHttp> {
  @override
  MetadadosHttp fromMap(Map<String, dynamic> map) => MetadadosHttp(
        paginaAtual: map['page'] as int? ?? 0,
        quantidadePaginaTotal: map['total_pages'] as int? ?? 0,
      );
}
