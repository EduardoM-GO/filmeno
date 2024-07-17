import 'package:filmeno/app/features/conteudo_detalhado/domain/entities/plataforma_streaming.dart';
import 'package:filmeno/app/features/conteudo_detalhado/domain/entities/tipo_acesso.dart';
import 'package:flutter/foundation.dart';

mixin PlataformasMapperMixin {
  @protected
  @visibleForTesting
  List<PlataformaStreaming> getPlataformas(Map<String, dynamic> map) {
    if (!map.containsKey('watch/providers')) {
      return [];
    }

    final Map<String, dynamic> providers = Map.from(map['watch/providers']);

    if (!providers.containsKey('results')) {
      return [];
    }

    final Map<String, dynamic> results = Map.from(providers['results']);

    if (!results.containsKey('BR')) {
      return [];
    }

    final Map<String, dynamic> streaming = Map.from(results['BR']);

    final String linkParaConteudo = streaming['link'];

    final List<PlataformaStreaming> plataformas = [];

    plataformas.addAll(getPlataformasDeAssinatura(
      map: streaming,
      link: linkParaConteudo,
    ));

    plataformas.addAll(getPlataformasDeAlugar(
      map: streaming,
      link: linkParaConteudo,
    ));

    plataformas.addAll(getPlataformasDeComprar(
      map: streaming,
      link: linkParaConteudo,
    ));

    return plataformas;
  }

  @visibleForTesting
  List<PlataformaStreaming> getPlataformasDeAssinatura({
    required Map<String, dynamic> map,
    required String link,
  }) {
    if (!map.containsKey('flatrate')) {
      return [];
    }

    final List<dynamic> assinaturas = map['flatrate'];

    return assinaturas.map<PlataformaStreaming>((e) {
      return PlataformaStreaming(
        codigo: e['provider_id'].toString(),
        nome: e['provider_name'],
        urlLogo: e['logo_path'],
        linkParaConteudo: link,
        tipoDeAcesso: TipoAcesso.assinatura,
      );
    }).toList();
  }

  @visibleForTesting
  List<PlataformaStreaming> getPlataformasDeAlugar({
    required Map<String, dynamic> map,
    required String link,
  }) {
    if (!map.containsKey('rent')) {
      return [];
    }

    final List<dynamic> compras = map['rent'];

    return compras.map<PlataformaStreaming>((e) {
      return PlataformaStreaming(
        codigo: e['provider_id'].toString(),
        nome: e['provider_name'],
        urlLogo: e['logo_path'],
        linkParaConteudo: link,
        tipoDeAcesso: TipoAcesso.alugar,
      );
    }).toList();
  }

  @visibleForTesting
  List<PlataformaStreaming> getPlataformasDeComprar({
    required Map<String, dynamic> map,
    required String link,
  }) {
    if (!map.containsKey('buy')) {
      return [];
    }

    final List<dynamic> gratuitos = map['buy'];

    return gratuitos.map<PlataformaStreaming>((e) {
      return PlataformaStreaming(
        codigo: e['provider_id'].toString(),
        nome: e['provider_name'],
        urlLogo: e['logo_path'],
        linkParaConteudo: link,
        tipoDeAcesso: TipoAcesso.comprar,
      );
    }).toList();
  }
}
