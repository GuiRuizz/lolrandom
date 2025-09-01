import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';

class LolApiDatasource {
  final Dio dio;
  LolApiDatasource(this.dio);

  Future<Map<String, dynamic>> getSummonerByName(String name) async {
    final response = await dio.get("${ApiConstants.summonerByName}/$name");
    return response.data;
  }

  Future<List<String>> getMatchHistory(String puuid) async {
    final response = await dio.get(
      "${ApiConstants.matchHistory}/$puuid/ids",
      queryParameters: {"start": 0, "count": 5},
    );
    return List<String>.from(response.data);
  }

  Future<String> getLatestVersion() async {
    final response = await dio.get(
      "https://ddragon.leagueoflegends.com/api/versions.json",
    );
    return (response.data as List).first;
  }
}
