import 'package:equatable/equatable.dart';
import 'package:filmeno/app/features/conteudo_detalhado/domain/entities/conteudo_detalhado.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:filmeno/app/shared/store/store.dart';
part 'conteudo_detalhado_state.dart';

final class ConteudoDetalhadoStore extends Store<ConteudoDetalhadoState> {
  
  ConteudoDetalhadoStore(): super(ConteudoDetalhadoInicialState());


}
