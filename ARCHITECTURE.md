# Arquitetura e Padrões de Projeto

## 1. Vertical Slices Architecture
Neste projeto, abandonamos a "Clean Architecture" de camadas horizontais (Data/Domain/Presentation) em favor de fatias verticais. 

**Vantagens:**
- **Baixo Acoplamento:** Alterar a lógica de busca de filmes não afeta a lógica de detalhes.
- **Agilidade:** Todo o código necessário para um recurso está em um único diretório.

**Estrutura da Slice:**
`lib/features/movie_search/`
- `movie_search_provider.dart` (Lógica e Estado)
- `movie_search_repository.dart` (Acesso a dados)
- `movie_search_view.dart` (UI)
- `movie_search_model.dart` (Entidades da fatia)

## 2. Functional Reactive Programming (FRP)
A lógica de negócio é tratada como uma série de transformações de dados.

- **TaskEither:** Usado para operações assíncronas que podem falhar. Garante que o erro seja tratado obrigatoriamente.
- **AsyncValue (Riverpod):** A UI reage a estados de carregamento, erro e sucesso de forma nativa e segura.

## 3. Fluxo de Dados (The Functional Pipe)
1. O usuário dispara um evento na View.
2. O Provider executa um `TaskEither`.
3. O Repositório compõe os dados (ex: Detalhes + Elenco).
4. O estado é atualizado via Riverpod Generator.
5. A UI se reconstrói baseada no novo valor imutável.


## Estrutura de Diretórios (Vertical Slices)

Para garantir o isolamento das funcionalidades e facilitar a manutenção, seguimos a estrutura abaixo:

```text
lib/
├── core/                           # Infraestrutura global (Network, Theme, UI Kit)
├── features/                       # Fatias Verticais de Negócio
│   ├── movie_trending/             # Cada funcionalidade é autossuficiente
│   │   ├── data/                   # Repositórios e DTOs locais
│   │   ├── domain/                 # Entidades e lógica de negócio local
│   │   └── presentation/           # Providers, Hooks e Widgets de UI
│   ├── movie_search/
│   └── movie_details/
├── shared/                         # Modelos e exceções compartilhadas (uso restrito)
└── main.dart                       # Inicialização do App e ProviderScope
```