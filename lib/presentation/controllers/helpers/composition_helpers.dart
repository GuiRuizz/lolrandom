import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/enum/modos_enum.dart';
import '../../../domain/entities/champion.dart';

/// Posicionamento aproximado das rotas no mapa
final Map<String, Offset> rotaPosicoes = {
  'top': const Offset(30, 50),
  'mid': const Offset(130, 180),
  'midInimigo': const Offset(200, 130),
  'support': const Offset(280, 300),
  'jungle': const Offset(80, 150),
  'adc': const Offset(220, 300),
};

/// Converte string do modo selecionado para o enum
extension ModosEnumParser on String {
  ModosEnum toModosEnum() {
    return ModosEnum.values.firstWhere(
      (e) => e.name == this,
      orElse: () => ModosEnum.solo,
    );
  }
}

/// Retorna a quantidade de personagens por rota para cada modo
Map<String, int> quantidadePorModo(ModosEnum modo) {
  switch (modo) {
    case ModosEnum.solo:
      return {'mid': 1};
    case ModosEnum.duo:
      return {'adc': 1, 'support': 1};
    case ModosEnum.trio:
      return {'top': 1, 'mid': 1, 'support': 1};
    case ModosEnum.jhin:
      return {'top': 1, 'mid': 1, 'adc': 1, 'jungle': 1};
    case ModosEnum.fullSquad:
      return {'top': 1, 'mid': 1, 'adc': 1, 'jungle': 1, 'support': 1};
    case ModosEnum.oneVsOne:
      return {'mid': 1, 'midInimigo': 1};
    case ModosEnum.oneVsFive:
      return {'midInimigo':1,'top': 1, 'mid': 1, 'adc': 1, 'jungle': 1, 'support': 1};
  }
}

/// Cria widgets de personagens com círculos coloridos (placeholder)
List<Widget> getPersonagensForModo(ModosEnum modo) {
  final quantidade = quantidadePorModo(modo);
  List<Widget> widgets = [];

  quantidade.forEach((rota, qtd) {
    final pos = rotaPosicoes[rota] ?? const Offset(150, 150);
    for (int i = 0; i < qtd; i++) {
      widgets.add(Positioned(
        left: pos.dx + i * 20,
        top: pos.dy,
        child: CircleAvatar(
          radius: 15,
          backgroundColor: Colors.blueAccent,
          child: Text(
            (i + 1).toString(),
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ));
    }
  });

  return widgets;
}

/// Cria widgets de campeões reais com imagens da API
List<Widget> getChampionsWidgets(
    List<Champion> champions,
    Map<String, int> quantidade,
    Map<String, Offset> posicoes,
) {
  final random = Random();
  List<Widget> widgets = [];

  quantidade.forEach((rota, qtd) {
    final pos = posicoes[rota] ?? const Offset(150, 150);

    for (int i = 0; i < qtd; i++) {
      final champ = champions[random.nextInt(champions.length)];

      widgets.add(Positioned(
        left: pos.dx + i * 25,
        top: pos.dy,
        child: CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(champ.imageUrl),
        ),
      ));
    }
  });

  return widgets;
}
