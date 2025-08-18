import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DrawerPersonalizado extends StatelessWidget {
  const DrawerPersonalizado({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Builder(
        builder: (drawerContext) { // Context correto para o GoRouter
          return ListView(
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
              _drawerItem(drawerContext, 'Página Inicial', '/'),
              _drawerItem(drawerContext, 'Ranking - Elo', '/ranking'),
              _drawerItem(drawerContext, 'Histórico de Partidas', '/historico'),
              _drawerItem(drawerContext, 'Skins', '/skins'),
              _drawerItem(drawerContext, 'Configurações', '/configuracoes'),
            ],
          );
        },
      ),
    );
  }

  // Método helper para criar itens do Drawer
  Widget _drawerItem(BuildContext context, String title, String route) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.of(context).pop(); // fecha o drawer
        context.go(route);           // navega usando GoRouter
      },
    );
  }
}
