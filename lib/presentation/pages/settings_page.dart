import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/enum/config_enum.dart';
import '../controllers/theme_controller.dart';
import '../widgets/drawer_personalizado.dart';
import '../widgets/pop_up_personalizado.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeControllerProvider);
    final themeController = ref.read(themeControllerProvider.notifier);

    final configSelecionado = ConfigEnumExtension.fromThemeMode(themeMode);
    final configs = ConfigEnum.values;

    return SafeArea(
      child: Scaffold(
        drawer: DrawerPersonalizado(),
        appBar: AppBar(
          title: const Text('Configurações'),
          centerTitle: true,
          actions: [PopUpMenuPersonalizado()],
        ),
        body: Center(
          child: Column(
            children: [
              ToggleButtons(
                isSelected: configs.map((c) => c == configSelecionado).toList(),
                onPressed: (index) {
                  final novoConfig = configs[index];
                  themeController.setTheme(novoConfig.toThemeMode);
                },
                borderRadius: BorderRadius.circular(20),
                selectedColor: Colors.white,
                fillColor: Colors.redAccent,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
                constraints: const BoxConstraints(minWidth: 120, minHeight: 40),
                children: configs.map((c) => Text(c.label)).toList(),
              ),

              const Spacer(),
              Text(
                'Versão do App: 1.0.0',
                style: TextStyle(
                  color: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.color?.withAlpha(50),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
