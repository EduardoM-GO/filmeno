# Roadmap

Este documento organiza o que sera implementado depois. A ordem pode mudar conforme testes de uso, limitacoes da API ou prioridades do projeto.

## Proxima etapa

### Melhorar recomendacoes

- Usar pesos diferentes para favorito, visto e quero assistir.
- Considerar generos, media type e titulos relacionados.
- Exibir o motivo de uma indicacao, como "porque voce favoritou filmes de ficcao cientifica".

### Melhorar biblioteca

- Criar filtros mais completos por status, genero e tipo de midia.
- Permitir ordenacao por data de adicao, popularidade ou avaliacao.
- Adicionar busca dentro da biblioteca local.

### Experiencia de detalhes

- Melhorar exibicao de provedores de streaming por pais.
- Adicionar trailers e links externos quando disponiveis.
- Exibir recomendacoes relacionadas diretamente na tela de detalhes.

## Medio prazo

### Conta e sincronizacao

- Avaliar autenticacao.
- Sincronizar biblioteca entre dispositivos.
- Preparar estrategia de backup e restauracao.

### Cache e modo offline

- Cachear respostas principais do TMDB.
- Permitir abrir a biblioteca sem internet.
- Diferenciar erro de rede, erro da API e dados ausentes.

### Qualidade visual

- Evoluir tema dinamico baseado em posters.
- Refinar responsividade para tablet, desktop e web.
- Padronizar estados vazios, loading, erro e skeletons.

## Longo prazo

### Inteligencia de descoberta

- Criar listas automaticas por humor, ocasiao ou genero.
- Montar sessoes sugeridas com mais de um titulo.
- Adicionar ranking pessoal do usuario.

### Social

- Compartilhar listas.
- Ver indicacoes de amigos.
- Criar listas colaborativas.

### Operacao e lancamento

- Preparar configuracoes de ambientes.
- Adicionar telemetria de erros.
- Definir checklist de publicacao para Android, iOS e web.

## Restricoes importantes

- Manter atribuicao ao TMDB nas telas que usam dados da API.
- Evitar consumo excessivo de memoria com imagens.
- Preservar a separacao por funcionalidades para que novas telas nao virem uma camada global dificil de manter.
