import 'package:go_router/go_router.dart';
import 'imports_router.dart';





final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'Página Inicial',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/configuracoes',
      name: 'Configurações',
      builder: (context, state) => SettingsPage(),
    ),
    GoRoute(
      path: '/ranking',
      name: 'Ranking - Elo',
      builder: (context, state) => RankingPage(),
    ),
    GoRoute(
      path: '/historico',
      name: 'Histórico de Partidas',
      builder: (context, state) => HistoryPage(),
    ),
    GoRoute(
      path: '/skins',
      name: 'Skins',
      builder: (context, state) => SkinsPage(),
    ),
    GoRoute(
      path: '/search',
      name: 'Buscar Campeão',
      builder: (context, state) => SearchPage(),
    ),

  ],
);