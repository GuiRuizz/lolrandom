import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';

class LolApiDataSource {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      headers: {
        "X-Riot-Token": ApiConstants.riotApiKey,
      },
    ),
  );

  Future<List<dynamic>> getChampions() async {
    final response = await _dio.get("/platform/v3/champion-rotations");
    return response.data;
  }
}
