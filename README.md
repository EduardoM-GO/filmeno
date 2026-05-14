# Filmeno 2.0 - Movie Intelligence Hub

O Filmeno 2.0 é um mecanismo de exploração de cinema de alta performance, projetado para oferecer uma experiência fluida e inteligente utilizando a API do TMDB. Diferente de arquiteturas tradicionais, este projeto foca em escalabilidade funcional e isolamento de recursos.

## 🚀 Diferenciais Técnicos
- **Vertical Slices Architecture:** Código organizado por funcionalidades (features), não por camadas técnicas globais.
- **Functional Reactive Programming (FRP):** Uso rigoroso de imutabilidade e fluxos de dados reativos.
- **Pragmatic Functional Error Handling:** Tratamento de falhas como valores de primeira classe (sem try-catch).
- **Adaptive UI:** Interface projetada para se adaptar dinamicamente ao contexto de Mobile, Desktop e Web.

## 🛠️ Stack Principal
- **Gerenciamento de Estado & DI:** Riverpod 2.0 (com Generators).
- **Programação Funcional:** fpdart (TaskEither, Option, Reader).
- **Interface:** Flutter Hooks + Material 3.
- **Networking:** Functional Wrapper sobre o pacote http nativo.