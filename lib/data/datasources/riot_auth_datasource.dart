import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../../core/utils/logger.dart';

class RiotAuthDatasource {
  final Dio dio;

  RiotAuthDatasource({required this.dio});

  Future<Map<String, dynamic>?> exchangeCodeForToken(String code) async {
    try {
      final response = await dio.post(
        ApiConstants.riotTokenEndpoint,
        options: Options(
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
        ),
        data: {
          "grant_type": "authorization_code",
          "code": code,
          "redirect_uri": ApiConstants.redirectUri,
          "client_id": ApiConstants.clientId,
        },
      );
      return response.data;
    } catch (e) {
      AppLogger.e("Erro ao trocar code por token: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>?> getUserInfo(String accessToken) async {
    try {
      final response = await dio.get(
        ApiConstants.riotUserInfoEndpoint,
        options: Options(
          headers: {"Authorization": "Bearer $accessToken"},
        ),
      );
      return response.data;
    } catch (e) {
      AppLogger.e("Erro ao buscar user info: $e");
      return null;
    }
  }
}
