# Arquitetura

# Objetivo

Esse documento tem por objetivo principal organizar o processo de desenvolvimento do software.

# Regras iniciais, limite e Análise

Pontos a serem levados em consideração antes de introduzir uma nova feature:

- Todo projeto precisará respeitar as regras de Lint escritas no pacote flutterando-analysis.
- Esse projeto deve ter cobertura mínima de testes de no mínimo 70%.
- Camadas globais devem ter um lugar específico na aplicação, por tanto, devem estar na pasta Shared.
- Cada feature deverá ter sua própria pasta onde conterá todas as camadas necessárias para a execução dos casos de uso da feature.
- Todos os designs patterns usados no projeto devem estar listados na sessão “Design Patterns” desse documento, caso contrário será considerado implementação errônea.
- Packages e plugins novos só poderão ser usados nos projetos após avaliação e aprovação de toda equipe responsável pelo projeto.
- Atualizações no Modelo de domínio só poderão ser aceitas se primeiro for adicionada nesse documento e aprovado por todos os envolvidos no projeto.
- Não é permitido ter uma classe concreta como dependência de uma camada. Só será aceita coesão com classes abstratas ou interfaces. Com exceção da Store.
- Cada camada deve ter apenas uma responsabilidade.
- Cada enum deve ser definido em seu próprio arquivo, semelhante a uma classe.


# Entidades

![image](diagrama_entidades.png)

# Casos de Uso

![image](diagrama_caso_de_uso.png)

# Design Patterns
- Datasource Pattern: Para acesso a API externa.
- Service Pattern: Para abstração de pacote de terceiros.
- Cache Pattern: Para manipulação de cache.
- Repository Pattern: Para Centralizar o datasource, service e cache.
- Domain Pattern: Para aplicação da regra de negocio
- Dependency Injection: Resolver dependências das classes.
- Store: Guardar e mudar estados.
- State pattern: Padrão que auxilia no gerenciamento estados.
- Json Mapper: Converter um json em classe.
- Result: Trabalhar com retorno Múltiplo.


# Package externos

- go_router: gerenciamento de rotas.
- get_it: injeção de dependências.
- result: Retorno múltiplo no formato Failure e Success.
- isar: Banco de dados.
- http: Para comunicação com API.
- url_launcher: Para abrir link.
- path_provider: Para obter o local do cache.
- equatable: usado para fazer comparação dos objetos.

# Package externos (Dev)

- Mocktail: Para testes de unidade.
- isar_generator: Converte a classe em uma collection do isar.
- build_runner: gerar os script automatico.
