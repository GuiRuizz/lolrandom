import 'package:dio/dio.dart';

import '../model/item_model.dart';

class LolItemsDatasource {
  final Dio dio;

  LolItemsDatasource(this.dio);

  Future<List<ItemModel>> getItems(String version) async {
    final url =
        'https://ddragon.leagueoflegends.com/cdn/$version/data/en_US/item.json';
    final response = await dio.get(url);

    final data = response.data['data'] as Map<String, dynamic>;

    return data.entries
        .where((e) {
          final item = e.value as Map<String, dynamic>;
          // Filtra itens que existem no mapa Summoner's Rift (mapa 11)
          final maps = item['maps'] as Map<String, dynamic>? ?? {};
          final existsOnSR = maps['11'] == true;

          // Filtra itens que possuem custo (itens válidos)
          final gold = item['gold'] as Map<String, dynamic>? ?? {};
          final hasCost = (gold['total'] ?? 0) > 0;

          return existsOnSR && hasCost;
        })
        .map((e) => ItemModel.fromMap(e.key, e.value, version))
        .toList();
  }
}
