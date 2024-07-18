import 'dart:async';

import 'package:filmeno/app/shared/domain/entities/configuracao.dart';
import 'package:flutter/material.dart';

class BotaoIconeFavoritoWidget extends StatefulWidget {
  final bool favoritado;

  /// Função que será chamada quando o botão for pressionado.
  ///
  /// o valor retornado será o novo valor de [favoritado].
  ///
  /// Se a função retornar `null`, nao vai substituir o valor do value .
  final FutureOr<bool?> Function(bool value) onChanged;
  const BotaoIconeFavoritoWidget({
    super.key,
    required this.favoritado,
    required this.onChanged,
  });

  @override
  State<BotaoIconeFavoritoWidget> createState() =>
      _BotaoIconeFavoritoWidgetState();
}

class _BotaoIconeFavoritoWidgetState extends State<BotaoIconeFavoritoWidget> {
  late bool favoritado;
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    favoritado = widget.favoritado;
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) => AnimatedSwitcher(
        duration: Configuracao.I.duracaoAnimacao,
        child: IconButton(
          isSelected: favoritado,
          onPressed: !isLoading
              ? () async {
                  if (isLoading) return;
                  setState(() {
                    isLoading = true;
                  });

                  bool favoritadoNovo = !favoritado;

                  bool? novoValor = await widget.onChanged(favoritadoNovo);

                  if (novoValor != null) {
                    favoritadoNovo = novoValor;
                  }

                  setState(() {
                    favoritado = favoritadoNovo;
                    isLoading = false;
                  });
                }
              : null,
          icon: const Icon(Icons.favorite_border),
          selectedIcon: const Icon(Icons.favorite),
        ),
      );
}
