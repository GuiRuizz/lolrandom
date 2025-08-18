import 'package:go_router/go_router.dart';
import 'package:lolrandom/presentation/pages/settings_page.dart';

import '../../presentation/pages/home_page.dart';



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
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/historico',
      name: 'Histórico de Partidas',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/skins',
      name: 'Skins',
      builder: (context, state) => HomePage(),
    ),

  ],
);