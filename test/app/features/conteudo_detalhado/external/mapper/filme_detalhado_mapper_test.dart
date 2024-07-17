import 'package:filmeno/app/features/conteudo_detalhado/domain/entities/filme_detalhado.dart';
import 'package:filmeno/app/features/conteudo_detalhado/domain/entities/plataforma_streaming.dart';
import 'package:filmeno/app/features/conteudo_detalhado/domain/entities/tipo_acesso.dart';
import 'package:filmeno/app/features/conteudo_detalhado/external/mapper/filme_detalhado_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../mock/map/filme_detalhado_map.dart';

void main() {
  late FilmeDetalhadoMapper mapper;

  setUp(() {
    mapper = FilmeDetalhadoMapper();
  });
  test('filme detalhado mapper - fromMap', () {
    const String link =
        "https://www.themoviedb.org/movie/719221-tarot/watch?locale=BR";
    final result = mapper.fromMap(filmeDetalhadoMap);

    expect(result, isA<FilmeDetalhado>());
    expect(
        result,
        equals(
          FilmeDetalhado(
            codigo: '719221',
            titulo: "O Tarô da Morte",
            urlCapa: '/h3852NLwbfkpZW8rLgUfMuDICfu.jpg',
            avaliacaoUsuario: 6.678,
            favorito: false,
            assistirMaisTarde: false,
            faixaEtaria: '',
            dataLancamento: DateTime.parse('2024-05-01'),
            duracao: const Duration(minutes: 92),
            generos: const ['Terror'],
            sinopse:
                "Quando um grupo de amigos irresponsavelmente viola a regra sagrada da leitura de tarô, a de nunca usar o deque de outra pessoa, eles libertam um mal inominável que estava preso nas cartas. Um por um, eles encaram seu destino e acabam em uma corrida contra a morte para escapar do futuro previsto para eles nas cartas.",
            plataformas: const [
              PlataformaStreaming(
                codigo: '167',
                nome: 'Claro video',
                urlLogo: '/21M5CpiOYGOhHj2sVPXqwt6yeTO.jpg',
                linkParaConteudo: link,
                tipoDeAcesso: TipoAcesso.alugar,
              ),
              PlataformaStreaming(
                codigo: '2',
                nome: 'Apple TV',
                urlLogo: '/9ghgSC0MA082EL6HLCW3GalykFD.jpg',
                linkParaConteudo: link,
                tipoDeAcesso: TipoAcesso.alugar,
              ),
              PlataformaStreaming(
                codigo: '10',
                nome: 'Amazon Video',
                urlLogo: '/seGSXajazLMCKGB5hnRCidtjay1.jpg',
                linkParaConteudo: link,
                tipoDeAcesso: TipoAcesso.alugar,
              ),
              PlataformaStreaming(
                codigo: '3',
                nome: 'Google Play Movies',
                urlLogo: '/8z7rC8uIDaTM91X0ZfkRf04ydj2.jpg',
                linkParaConteudo: link,
                tipoDeAcesso: TipoAcesso.alugar,
              ),
              PlataformaStreaming(
                codigo: '68',
                nome: 'Microsoft Store',
                urlLogo: '/5vfrJQgNe9UnHVgVNAwZTy0Jo9o.jpg',
                linkParaConteudo: link,
                tipoDeAcesso: TipoAcesso.alugar,
              ),
              PlataformaStreaming(
                codigo: '2',
                nome: 'Apple TV',
                urlLogo: '/9ghgSC0MA082EL6HLCW3GalykFD.jpg',
                linkParaConteudo: link,
                tipoDeAcesso: TipoAcesso.comprar,
              ),
              PlataformaStreaming(
                codigo: '10',
                nome: 'Amazon Video',
                urlLogo: '/seGSXajazLMCKGB5hnRCidtjay1.jpg',
                linkParaConteudo: link,
                tipoDeAcesso: TipoAcesso.comprar,
              ),
              PlataformaStreaming(
                codigo: '3',
                nome: 'Google Play Movies',
                urlLogo: '/8z7rC8uIDaTM91X0ZfkRf04ydj2.jpg',
                linkParaConteudo: link,
                tipoDeAcesso: TipoAcesso.comprar,
              ),
              PlataformaStreaming(
                codigo: '68',
                nome: 'Microsoft Store',
                urlLogo: '/5vfrJQgNe9UnHVgVNAwZTy0Jo9o.jpg',
                linkParaConteudo: link,
                tipoDeAcesso: TipoAcesso.comprar,
              ),
            ],
          ),
        ));
  });
}
