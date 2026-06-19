# Proposta do Projeto

## Visao geral

Filmeno e um hub de descoberta cinematografica. A proposta e ajudar o usuario a sair do ciclo de abrir varios streamings sem decidir o que assistir, reunindo descoberta, busca, detalhes, biblioteca pessoal e indicacoes em uma unica experiencia.

O app usa dados do TMDB para apresentar filmes e series em alta, detalhes de cada titulo, elenco, provedores de streaming e informacoes que ajudam o usuario a decidir rapidamente.

## Problema que o app resolve

Escolher um filme ou serie costuma envolver varias etapas espalhadas:

- verificar o que esta em alta;
- procurar detalhes, nota, sinopse e elenco;
- descobrir onde assistir;
- lembrar o que ja foi visto ou salvo;
- receber sugestoes que tenham relacao com o gosto pessoal.

Filmeno centraliza esse fluxo e cria uma base local de preferencias para melhorar as proximas recomendacoes.

## Publico-alvo

- Pessoas que assistem filmes e series com frequencia.
- Usuarios que gostam de manter uma lista do que querem assistir.
- Usuarios que querem recomendacoes sem depender apenas da pagina inicial dos streamings.
- Pessoas que alternam entre celular, tablet, desktop ou web.

## Funcionalidades atuais

### Em alta

Tela inicial com filmes e series populares, filtros por tipo de midia, carregamento paginado e atualizacao manual.

### Busca

Busca de titulos com componente reutilizavel na interface. Os resultados usam modelo proprio e tratam filmes, series e outros tipos de midia suportados pela API.

### Detalhes

Tela dedicada para um titulo, com cabecalho, sinopse, generos, elenco e provedores de streaming quando disponiveis.

### Biblioteca do usuario

Area para salvar interacoes locais com filmes e series, usando status como interesse, favorito ou visto. Essa base serve como memoria pessoal do usuario dentro do app.

### Indicacoes

Tela de recomendacoes baseada nas interacoes registradas. Quando ainda nao ha dados suficientes, o app orienta o usuario a curtir ou favoritar titulos para calibrar as sugestoes.

### Navegacao adaptativa

Em telas menores, o app usa navegacao inferior. Em telas maiores, usa `NavigationRail`, mantendo o mesmo conjunto de destinos com melhor aproveitamento de espaco.

## Principios de produto

- A decisao do que assistir deve ser rapida.
- A interface deve ser visual, mas sem esconder informacoes importantes.
- Falhas de rede devem ser comunicadas com clareza.
- A biblioteca local deve ser simples e confiavel.
- As recomendacoes devem melhorar conforme o usuario interage.
