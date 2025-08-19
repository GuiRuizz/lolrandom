import 'package:flutter/material.dart';

import '../../core/utils/logger.dart';

class PopUpMenuPersonalizado extends StatelessWidget {
  const PopUpMenuPersonalizado({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
            onSelected: (value) {
    // Aqui você trata a ação do item selecionado
    AppLogger.i('Menu selecionado: $value');
    if (value == 'Sair') {
      // exemplo de ação
      Navigator.pop(context);
    }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
    const PopupMenuItem<String>(
      value: 'Perfil',
      child: Text('Perfil'),
    ),
    const PopupMenuItem<String>(
      value: 'Sair',
      child: Text('Sair'),
    ),
            ],
            icon: const Icon(Icons.person_rounded), // ícone do menu
          );
  }
}