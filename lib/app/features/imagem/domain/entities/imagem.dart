import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part 'imagem.g.dart';

@Collection(ignore: {'props'})
class Imagem extends Equatable {
  final Id? id;
  @Index(type: IndexType.value)
  final DateTime dataCriacao;
  @Index(type: IndexType.hash, unique: true, replace: true)
  final String url;

  final List<byte> imagem;

  const Imagem({
    this.id,
    required this.dataCriacao,
    required this.url,
    required this.imagem,
  });

  bool get isNotEmpty => url.isNotEmpty;

  factory Imagem.empty() => Imagem(
        dataCriacao: DateTime(0),
        url: '',
        imagem: const [],
      );

  @override
  List<Object?> get props => [id, dataCriacao, url, imagem];
}
