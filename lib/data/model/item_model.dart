import '../../domain/entities/item.dart';

class ItemModel extends Item {
  ItemModel({
    required super.id,
    required super.name,
    required super.imageUrl,
  });

  /// Construtor que recebe o ID e o mapa do item do JSON
  factory ItemModel.fromMap(String id, Map<String, dynamic> json, String version) {
    return ItemModel(
      id: id,
      name: json['name'],
      // URL completa para a imageUrlm do item
      imageUrl: "https://ddragon.leagueoflegends.com/cdn/$version/img/item/$id.png",
    );
  }
}
