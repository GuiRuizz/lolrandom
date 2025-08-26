import '../../domain/entities/champion.dart';

class ChampionModel extends Champion {
  ChampionModel({
    required super.id,
    required super.name,
    required super.title,
    required super.imageUrl,
  });

  factory ChampionModel.fromJson(Map<String, dynamic> json, String version) {
    final id = json["id"];
    return ChampionModel(
      id: id,
      name: json["name"],
      title: json["title"],
      imageUrl:
          "https://ddragon.leagueoflegends.com/cdn/$version/img/champion/$id.png",
    );
  }
}
