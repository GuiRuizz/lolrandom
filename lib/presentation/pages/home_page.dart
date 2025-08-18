import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/theme_controller.dart';
import '../widgets/drawer_personalizado.dart';
import 'settings_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeController = ref.read(themeControllerProvider.notifier);

    return Scaffold(
      drawer: DrawerPersonalizado(),
      appBar: AppBar(title: const Text('LoL Champions App'), 
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => themeController.setTheme(ThemeMode.system),
              child: const Text('Seguir o sistema'),
            ),
            ElevatedButton(
              onPressed: () => themeController.setTheme(ThemeMode.light),
              child: const Text('Sempre Claro'),
            ),
            ElevatedButton(
              onPressed: () => themeController.setTheme(ThemeMode.dark),
              child: const Text('Sempre Escuro'),
            ),
          ],
        ),
      ),
    );
  }
}




