import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import '../../core/constants/api_constants.dart';
import '../../core/dio/dio_provider.dart';
import '../../core/utils/logger.dart';

/// Provider do controller
final riotAuthProvider = Provider<RiotAuthController>((ref) {
  final dio = ref.read(dioProvider);
  return RiotAuthController(dio);
});

/// Provider que guarda os dados do usuário logado
final riotUserProvider = StateProvider<Map<String, dynamic>?>((ref) => null);

class RiotAuthController {
  final Dio dio;

  RiotAuthController(this.dio);

  /// Faz login via RSO
  Future<Map<String, dynamic>?> login() async {
    try {
      // 1️⃣ Abrir login da Riot
      final result = await FlutterWebAuth2.authenticate(
        url:
            "${ApiConstants.riotAuthEndpoint}?client_id=${ApiConstants.clientId}&redirect_uri=${ApiConstants.redirectUri}&response_type=code&scope=openid",
        callbackUrlScheme: Uri.parse(
          ApiConstants.redirectUri,
        ).scheme, // "https"
      );

      // 2️⃣ Captura o código retornado
      final code = Uri.parse(result).queryParameters['code'];
      if (code == null) return null;

      // 3️⃣ Troca o código por access_token (sem client secret)
      final tokenResponse = await dio.post(
        ApiConstants.riotTokenEndpoint,
        options: Options(
          headers: {"Content-Type": "application/x-www-form-urlencoded"},
        ),
        data: {
          "grant_type": "authorization_code",
          "code": code,
          "redirect_uri": ApiConstants.redirectUri,
          "client_id": ApiConstants.clientId,
        },
      );

      final tokenData = tokenResponse.data as Map<String, dynamic>;
      final accessToken = tokenData["access_token"];

      // 4️⃣ Busca info do usuário (PUUID, gameName, tagLine)
      final userResponse = await dio.get(
        ApiConstants.riotUserInfoEndpoint,
        options: Options(headers: {"Authorization": "Bearer $accessToken"}),
      );

      final userData = userResponse.data as Map<String, dynamic>;
      AppLogger.i(
        "Usuário logado: ${userData['gameName']}#${userData['tagLine']}",
      );

      return userData;
    } catch (e) {
      AppLogger.e("Erro no login RSO: $e");
      return null;
    }
  }
}
