import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DrawerPersonalizado extends StatelessWidget {
  const DrawerPersonalizado({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/map/map11.png'),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'GamerTag - X',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Página Inicial'),
              onTap: () {
                context.go('/');
              },
            ),
            ListTile(
              title: const Text('Ranking - Elo'),
              onTap: () {
                context.go('/ranking');
              },
            ),
            ListTile(
              title: const Text('Histórico de Partidas'),
              onTap: () {
                context.go('/historico');
              },
            ),
            ListTile(
              title: const Text('Skins'),
              onTap: () {
                context.go('/skins');
              },
            ),
            ListTile(
              title: const Text('Configurações'),
              onTap: () {
                context.go('/configuracoes');
              },
            ),
          ],
        ),
      );
  }
}