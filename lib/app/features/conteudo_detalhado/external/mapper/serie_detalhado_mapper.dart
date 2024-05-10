import 'package:filmeno/app/features/conteudo_detalhado/domain/entities/serie_detalhada.dart';
import 'package:filmeno/app/shared/external/mapper/mapper.dart';
import 'package:intl/intl.dart';

class SerieDetalhadoMapper implements Mapper<SerieDetalhada> {
  @override
  SerieDetalhada fromMap(Map<String, dynamic> map) => SerieDetalhada(
        codigo: map['id'].toString(),
        titulo: map['name'],
        urlCapa: map['poster_path'],
        avaliacaoUsuario: map['vote_average'],
        favorito: false,
        assistirMaisTarde: false,
        faixaEtaria: _getFaixaEtaria(map['content_ratings']),
        dataLancamento: DateFormat('yyyy-MM-dd').parse(map['first_air_date']),
        quantidadeDeEpisodios: map['number_of_episodes'],
        quantidadeDeTemporada: map['number_of_seasons'],
        generos: map['genres'].map<String>((e) => e['name']).toList(),
        sinopse: map['overview'],
        //Todo: Achar uma forma de obter os link de redirecionamento para as plataformas de streaming
        plataformas: plataformas,
      );

  String _getFaixaEtaria(Map<String, dynamic> map) {
    final List<dynamic> results = map['results'];

    final Map<String, dynamic> result = results.firstWhere(
      (element) => element['iso_3166_1'] == 'BR',
      orElse: () => {'rating': ''},
    );

    return result['rating'];
  }
}
