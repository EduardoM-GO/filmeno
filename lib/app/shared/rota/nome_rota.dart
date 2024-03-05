enum NomeRota {
  splash('/'),
  home('/home'),
  ; 

  final String caminho;

  const NomeRota(this.caminho);

  @override
  String toString() => caminho;

}
