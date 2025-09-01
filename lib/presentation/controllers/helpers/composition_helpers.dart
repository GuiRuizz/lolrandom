import 'dart:math';

import 'package:flutter/material.dart';
import '../../../core/enum/modos_enum.dart';
import '../../../domain/entities/champion.dart';
import '../../../domain/entities/champion_item.dart';
import '../../../domain/entities/item.dart';

/// Posicionamento aproximado das rotas no mapa
final Map<String, Offset> rotaPosicoes = {
  'top': const Offset(10, 30),
  'mid': const Offset(100, 180),
  'midInimigo': const Offset(180, 100),
  'support': const Offset(260, 250),
  'jungle': const Offset(40, 120),
  'adc': const Offset(180, 250),
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

/// Cria widgets de campeões reais com imagens da API
List<Widget> getChampionsWidgetsFromGenerated(
    List<ChampionWithItems> campeoesGerados,
    Map<String, Offset> posicoes,
    Map<String, int> quantidade,
) {
  List<Widget> widgets = [];
  int index = 0;

  quantidade.forEach((rota, qtd) {
    final pos = posicoes[rota] ?? const Offset(150, 150);

    for (int i = 0; i < qtd; i++) {
      if (index >= campeoesGerados.length) index = 0;
      final champ = campeoesGerados[index].champion;
      index++;

      widgets.add(Positioned(
        left: pos.dx + i * 25,
        top: pos.dy,
        child: CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(champ.imageUrl),
        ),
      ));
    }
  });

  return widgets;
}


/// Gera 6 itens aleatórios por campeão, garantindo pelo menos uma bota
List<List<Item>> generateItemsForChampionsApi(
    List<Item> allItems, int numChampions) {
  final random = Random();
  final boots = allItems.where((i) => i.name.toLowerCase().contains('boot')).toList();
  final otherItems = allItems.where((i) => !i.name.toLowerCase().contains('boot')).toList();

  List<List<Item>> itemsPerChampion = [];

  for (int i = 0; i < numChampions; i++) {
    List<Item> items = [];

    // Adiciona uma bota
    items.add(boots[random.nextInt(boots.length)]);

    // Adiciona mais 5 itens aleatórios
    final shuffled = List<Item>.from(otherItems)..shuffle();
    items.addAll(shuffled.take(5));

    itemsPerChampion.add(items);
  }

  return itemsPerChampion;
}

List<ChampionWithItems> generateChampionsWithItems(
  List<Champion> champions,
  List<Item> allItems,
  Map<String, int> quantidadePorRota,
) {
  final random = Random();
  final boots = allItems.where((i) => i.name.toLowerCase().contains('boot')).toList();
  final otherItems = allItems.where((i) => !i.name.toLowerCase().contains('boot')).toList();

  final shuffledChampions = List<Champion>.from(champions)..shuffle();
  int champIndex = 0;

  List<ChampionWithItems> result = [];

  quantidadePorRota.forEach((rota, qtd) {
    for (int i = 0; i < qtd; i++) {
      if (champIndex >= shuffledChampions.length) champIndex = 0;
      final champ = shuffledChampions[champIndex];
      champIndex++;

      // Gera itens aleatórios
      List<Item> items = [];
      if (boots.isNotEmpty) {
        items.add(boots[random.nextInt(boots.length)]);
      }
      final shuffled = List<Item>.from(otherItems)..shuffle();
      items.addAll(shuffled.take(5));

      result.add(ChampionWithItems(champion: champ, items: items));
    }
  });

  return result;
}
