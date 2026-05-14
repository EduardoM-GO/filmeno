# Objetivos de Engenharia e UX

## 🎯 Funcionalidades "Turbinadas"
1. **Smart Search Multi-Entity:** Busca unificada (Filmes, Séries, Atores) com debounce funcional e cancelamento de requests obsoletos.
2. **Dynamic Palette Extraction:** O tema do app (cores primárias/secundárias) é extraído dinamicamente do poster do filme em destaque.
3. **Graceful Degradation:** Em falhas de rede, o app exibe componentes parciais (ex: detalhes sem elenco) em vez de uma tela de erro bloqueante.
4. **Adaptive Navigation:** Troca automática entre BottomNavigationBar (Mobile) e NavigationRail (Desktop).

## ⚠️ Restrições e Conformidade
- **Atribuição TMDB:** É obrigatório exibir o logo e crédito ao TMDB em todas as telas de dados.
- **Performance de Imagem:** Uso de cache agressivo e redimensionamento dinâmico para evitar overhead de memória RAM em dispositivos mobile.