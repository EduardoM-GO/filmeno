import 'package:isar/isar.dart';

part 'imagem.g.dart';

@collection
class Imagem {
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

  @ignore
  factory Imagem.empty() => Imagem(
        dataCriacao: DateTime(0),
        url: '',
        imagem: [],
      );
}
