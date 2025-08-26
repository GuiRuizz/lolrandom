import '../../domain/entities/champion.dart';
import '../datasources/lol_api_datasource.dart';
import '../model/champion_model.dart';
import 'composition_repository.dart';

class CompositionRepositoryImpl implements CompositionRepository {
  final LolApiDatasource datasource;
  final String version;
  CompositionRepositoryImpl(this.datasource, {required this.version});

  @override
  Future<List<Champion>> getChampions() async {
    final response = await datasource.dio.get(
      "https://ddragon.leagueoflegends.com/cdn/$version/data/pt_BR/champion.json"
    );

    final data = response.data["data"] as Map<String, dynamic>;
    return data.values
        .map((champ) => ChampionModel.fromJson(champ, version))
        .toList();
  }
}

