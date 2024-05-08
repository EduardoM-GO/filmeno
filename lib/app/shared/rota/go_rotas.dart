import 'package:filmeno/app/features/conteudo/domain/entities/filme.dart';
import 'package:filmeno/app/features/conteudo/domain/entities/serie.dart';
import 'package:filmeno/app/features/conteudo/domain/repositories/filme_repository.dart';
import 'package:filmeno/app/features/conteudo/domain/repositories/serie_repository.dart';
import 'package:filmeno/app/features/conteudo/domain/use_cases/buscar_filmes_em_cartaz_use_case.dart';
import 'package:filmeno/app/features/conteudo/domain/use_cases/buscar_filmes_melhores_avalidados_use_case.dart';
import 'package:filmeno/app/features/conteudo/domain/use_cases/buscar_filmes_populares_use_case.dart';
import 'package:filmeno/app/features/conteudo/domain/use_cases/buscar_filmes_proximas_estreias_use_case.dart';
import 'package:filmeno/app/features/conteudo/domain/use_cases/buscar_series_melhores_avaliados_use_case.dart';
import 'package:filmeno/app/features/conteudo/domain/use_cases/buscar_series_populares_use_case.dart';
import 'package:filmeno/app/features/conteudo/domain/use_cases/buscar_series_vai_ser_exibido_hoje_use_case.dart';
import 'package:filmeno/app/features/conteudo/domain/use_cases/buscar_series_vai_ser_exibido_na_semana_use_case.dart';
import 'package:filmeno/app/features/conteudo/external/datasources/filme_datasource_impl.dart';
import 'package:filmeno/app/features/conteudo/external/datasources/serie_datasource_impl.dart';
import 'package:filmeno/app/features/conteudo/external/mapper/filme_mapper.dart';
import 'package:filmeno/app/features/conteudo/external/mapper/serie_mapper.dart';
import 'package:filmeno/app/features/conteudo/infra/datasources/filme_datasource.dart';
import 'package:filmeno/app/features/conteudo/infra/datasources/serie_datasource.dart';
import 'package:filmeno/app/features/conteudo/infra/repositories/filme_repository_impl.dart';
import 'package:filmeno/app/features/conteudo/infra/repositories/serie_repository_impl.dart';
import 'package:filmeno/app/features/home/page/home_page.dart';
import 'package:filmeno/app/features/imagem/domain/repositories/imagem_repository.dart';
import 'package:filmeno/app/features/imagem/external/cache/imagem_cache_impl.dart';
import 'package:filmeno/app/features/imagem/external/datasources/imagem_datasource_impl.dart';
import 'package:filmeno/app/features/imagem/infra/cache/imagem_cache.dart';
import 'package:filmeno/app/features/imagem/infra/datasources/imagem_datasource.dart';
import 'package:filmeno/app/features/imagem/infra/repositories/imagem_repository_impl.dart';
import 'package:filmeno/app/features/splash/page/splash_page.dart';
import 'package:filmeno/app/shared/external/mapper/mapper.dart';
import 'package:filmeno/app/shared/rota/go_rota.dart';
import 'package:filmeno/app/shared/rota/nome_rota.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

part 'rotas.dart';

class GoRotas extends GoRouter {
  GoRotas()
      : super.routingConfig(
          routingConfig: ValueNotifier(
            RoutingConfig(routes: rotas, redirectLimit: 5),
          ),
          routerNeglect: false,
          overridePlatformDefaultLocation: false,
          debugLogDiagnostics: false,
          requestFocus: true,
        );
}
