import 'package:filmeno/app/features/conteudo/components/lista_conteudo/lista_conteudo_component.dart';
import 'package:filmeno/app/features/conteudo/domain/use_cases/buscar_filmes_em_cartaz_use_case.dart';
import 'package:filmeno/app/features/conteudo/domain/use_cases/buscar_filmes_melhores_avalidados_use_case.dart';
import 'package:filmeno/app/features/conteudo/domain/use_cases/buscar_filmes_populares_use_case.dart';
import 'package:filmeno/app/features/conteudo/domain/use_cases/buscar_filmes_proximas_estreias_use_case.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filmeno'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            ListaConteudoComponent(
              titulo: 'Em cartaz',
              useCase: GetIt.I.get<BuscarFilmesEmCartazUseCase>().call,
            ),
            const SizedBox(height: 16),
            ListaConteudoComponent(
              titulo: 'Melhores avaliados',
              useCase:
                  GetIt.I.get<BuscarFilmesMelhoresAvalidadosUseCase>().call,
            ),
            const SizedBox(height: 16),
            ListaConteudoComponent(
              titulo: 'Populares',
              useCase: GetIt.I.get<BuscarFilmesPopularesUseCase>().call,
            ),
            const SizedBox(height: 16),
            ListaConteudoComponent(
              titulo: 'Proxima estreia',
              useCase: GetIt.I.get<BuscarFilmesProximasEstreiasUseCase>().call,
            ),
          ],
        ),
      ),
    );
  }
}
