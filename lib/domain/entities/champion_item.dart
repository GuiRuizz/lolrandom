import 'champion.dart';
import 'item.dart';

class ChampionWithItems {
  final Champion champion;
  final List<Item> items;

  ChampionWithItems({
    required this.champion,
    required this.items,
  });
}
