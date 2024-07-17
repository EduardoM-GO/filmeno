import 'package:filmeno/app/features/conteudo_detalhado/domain/entities/filme_detalhado.dart';
import 'package:filmeno/app/shared/external/mapper/generos_mapper_mixin.dart';
import 'package:filmeno/app/shared/external/mapper/mapper.dart';
import 'package:filmeno/app/shared/external/mapper/plataformas_mapper_mixin.dart';
import 'package:intl/intl.dart';

class FilmeDetalhadoMapper
    with PlataformasMapperMixin, GenerosMapperMixin
    implements Mapper<FilmeDetalhado> {
  @override
  FilmeDetalhado fromMap(Map<String, dynamic> map) => FilmeDetalhado(
        codigo: map['id'].toString(),
        titulo: map['title'],
        urlCapa: map['poster_path'],
        avaliacaoUsuario: map['vote_average'],
        favorito: false,
        assistirMaisTarde: false,
        faixaEtaria: '',
        dataLancamento: DateFormat('yyyy-MM-dd').parse(map['release_date']),
        duracao: Duration(minutes: map['runtime']),
        generos: getGeneros(map),
        sinopse: map['overview'],
        plataformas: getPlataformas(map),
      );
}
