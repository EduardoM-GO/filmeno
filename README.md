# Filmeno

Filmeno e um aplicativo Flutter para descobrir, pesquisar, organizar e receber indicacoes de filmes e series usando dados do TMDB.

O objetivo do projeto e transformar a escolha do que assistir em uma experiencia mais simples: o usuario encontra titulos em alta, consulta detalhes, salva sua biblioteca pessoal e recebe recomendacoes baseadas nas interacoes feitas dentro do app.

## Documentacao

- [Proposta do projeto](docs/PRODUCT.md): explica o que o Filmeno propoe resolver, o publico-alvo e as funcionalidades atuais.
- [Roadmap](docs/ROADMAP.md): lista o que ainda sera implementado e como as proximas entregas estao organizadas.
- [Arquitetura](docs/ARCHITECTURE.md): descreve a organizacao tecnica, fluxo de dados, dependencias e padroes usados no codigo.

## Stack principal

- Flutter com Material 3.
- Riverpod e Riverpod Generator para estado e injecao de dependencias.
- Flutter Hooks para estado local de tela.
- `fpdart` para modelar operacoes funcionais e falhas como valores.
- `http` para comunicacao com a API.
- `sembast` para persistencia local.
- `cached_network_image` para imagens remotas com cache.

## Funcionalidades atuais

- Listagem de filmes e series em alta.
- Busca de titulos com suporte a diferentes tipos de midia.
- Tela de detalhes com informacoes do titulo, elenco e provedores de streaming.
- Biblioteca local do usuario com status de interacao.
- Indicacoes baseadas nas preferencias registradas pelo usuario.
- Navegacao adaptativa entre mobile e telas maiores.

## Como rodar

1. Instale as dependencias:

```bash
flutter pub get
```

2. Gere os arquivos do Riverpod:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

3. Execute o app informando as configuracoes da API:

```bash
flutter run \
  --dart-define=BASE_URL=https://api.themoviedb.org/3 \
  --dart-define=BASE_IMAGE_URL=https://image.tmdb.org/t/p \
  --dart-define=ACCESS_TOKEN=<seu_token_do_tmdb>
```

## Variaveis e API

O projeto usa dados do TMDB e le `BASE_URL`, `BASE_IMAGE_URL` e `ACCESS_TOKEN` via `String.fromEnvironment`. Consulte [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) para entender onde ficam as configuracoes de rede e como a integracao esta organizada.
