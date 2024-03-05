import 'dart:async';
import 'dart:io';

import 'package:filmeno/app/shared/domain/entities/metadados.dart';
import 'package:filmeno/app/shared/external/mapper/mapper.dart';
import 'package:filmeno/app/shared/external/mapper/metadados_mapper.dart';
import 'package:filmeno/app/shared/external/service/cliente_http_service_impl.dart';
import 'package:filmeno/app/shared/external/service/db_helper_service_impl.dart';
import 'package:filmeno/app/shared/infra/service/cliente_http_service.dart';
import 'package:filmeno/app/shared/infra/service/db_helper_service.dart';
import 'package:filmeno/app/shared/rota/nome_rota.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() {
      injetarDependenciasGlobal().then((_) {
        context.pushReplacement(NomeRota.home.caminho);
      });
    });
  }

  Future<void> injetarDependenciasGlobal() async {
    GetIt.I.registerSingletonAsync<Directory>(
        () async => getApplicationDocumentsDirectory());
    await GetIt.I.allReady();
    GetIt.I
        .registerSingleton<DbHelperService>(DbHelperServiceImpl(GetIt.I.get()));
    GetIt.I.registerFactory<Client>(() => Client());
    GetIt.I.registerFactory<Mapper<Metadados>>(() => MetadadosMapper());
    GetIt.I.registerSingleton<ClienteHttpService>(
        ClienteHttpServiceImpl(GetIt.I.get(), GetIt.I.get()));
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
