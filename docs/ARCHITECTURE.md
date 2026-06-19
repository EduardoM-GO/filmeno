# Arquitetura

## Visao geral

Filmeno usa uma arquitetura por funcionalidades, tambem conhecida como vertical slices. Cada feature concentra sua UI, estado, modelos de dominio e acesso a dados no mesmo diretorio.

Essa organizacao deixa claro onde uma mudanca deve acontecer. Alteracoes em busca, detalhes, recomendacoes ou biblioteca tendem a ficar isoladas dentro da propria feature.

## Estrutura principal

```text
lib/
├── core/
│   ├── local_storage/      # Provedor do banco local Sembast
│   ├── network/            # Configuracao de API, cliente HTTP e providers globais
│   ├── theme/              # Tema dinamico do app
│   └── ui_kit/             # Componentes reutilizaveis de interface
├── features/
│   ├── movie_details/      # Detalhes, elenco, generos e onde assistir
│   ├── movie_recommendations/
│   ├── movie_search/
│   ├── movie_trending/
│   ├── navigation/
│   └── user_profile/       # Biblioteca e interacoes locais do usuario
├── shared/
│   └── exceptions/         # Tipos compartilhados de falha
└── main.dart               # Inicializacao do app e ProviderScope
```

## Padrao interno das features

As features seguem uma divisao simples:

```text
feature/
├── data/           # Repositories e acesso a fontes externas ou locais
├── domain/         # Entidades, enums e regras da feature
└── presentation/   # Pages, notifiers, providers e widgets
```

Nem toda feature precisa ter todas as pastas. A estrutura deve crescer conforme a necessidade real da funcionalidade.

## Fluxo de dados

1. O usuario interage com uma tela ou widget.
2. A camada de presentation aciona um notifier/provider do Riverpod.
3. O notifier chama um repository da propria feature.
4. O repository acessa API, banco local ou outro provider de infraestrutura.
5. O resultado volta para o notifier como sucesso ou falha.
6. A UI reage ao novo estado usando `AsyncValue`.

## Estado e injecao de dependencias

O projeto usa Riverpod para:

- expor repositories;
- controlar estados assíncronos de telas;
- compartilhar providers de infraestrutura;
- reduzir acoplamento entre UI e fontes de dados.

Os arquivos `.g.dart` sao gerados pelo Riverpod Generator e nao devem ser editados manualmente.

## Tratamento de falhas

Falhas sao modeladas com o tipo compartilhado `Falha`, localizado em `lib/shared/exceptions/falha.dart`.

Operacoes que podem falhar devem retornar valores que expressem sucesso ou erro de forma explicita, evitando esconder problemas em excecoes soltas pela UI.

## Rede

A infraestrutura de rede fica em `lib/core/network/`.

- `api_config.dart`: configuracoes e constantes da API.
- `functional_client.dart`: wrapper funcional sobre chamadas HTTP.
- `network_providers.dart`: providers de rede usados pelas features.

`ApiConfig` le `BASE_URL`, `BASE_IMAGE_URL` e `ACCESS_TOKEN` via `String.fromEnvironment`, entao esses valores devem ser informados por `--dart-define` ao rodar ou buildar o app.

As features nao devem montar clientes HTTP diretamente quando houver provider global disponivel.

## Persistencia local

A persistencia local usa Sembast e fica centralizada em `lib/core/local_storage/sembast_provider.dart`.

A feature `user_profile` usa essa base para manter interacoes do usuario, como biblioteca, favoritos e status dos titulos.

## UI compartilhada

Componentes reutilizaveis vivem em `lib/core/ui_kit/widgets/`. Exemplos:

- grid adaptativo de filmes;
- estados de carregamento, erro e vazio;
- shell de pagina;
- controles de interacao;
- filtros por tipo de midia.

Widgets especificos de uma feature devem permanecer dentro da propria feature.

## Navegacao

A navegacao principal fica em `lib/features/navigation/presentation/main_page_widget.dart`.

Ela alterna entre:

- `NavigationBar` em telas menores;
- `NavigationRail` em telas largas.

As paginas principais sao mantidas em um `IndexedStack`, preservando o estado de cada aba durante a navegacao.

## Regras para evoluir o codigo

- Criar novas funcionalidades dentro de `lib/features/<nome_da_feature>/`.
- Reutilizar `core/ui_kit` apenas para componentes realmente compartilhados.
- Evitar models globais quando o dado pertence a uma feature especifica.
- Manter acesso a API e banco fora dos widgets.
- Regenerar arquivos do Riverpod apos alterar providers anotados.
- Cobrir repositories e fluxo de estado com testes quando houver regra de negocio ou tratamento de erro relevante.
