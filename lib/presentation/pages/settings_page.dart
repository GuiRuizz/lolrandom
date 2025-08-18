import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/theme_controller.dart';


class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeController = ref.read(themeControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      body:Column(
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
    );
  }
}