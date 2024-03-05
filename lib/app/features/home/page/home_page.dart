import 'package:filmeno/app/features/conteudo/components/lista_conteudo/lista_conteudo_component.dart';
import 'package:filmeno/app/features/conteudo/domain/use_cases/buscar_filmes_em_cartaz_use_case.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('T'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListaConteudoComponent(
            useCase: GetIt.I.get<BuscarFilmesEmCartazUseCase>().call,
          ),
        ],
      ),
    );
  }
}
