import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/api_constants.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl, // servidor (mude conforme região)
      headers: {
        "X-Riot-Token": dotenv.env['API_RIOT_KEY'], // coloque sua API key
      },
    ),
  );
  return dio;
});
