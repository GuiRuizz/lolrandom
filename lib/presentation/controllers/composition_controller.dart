import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/composition_repository.dart';
import '../../domain/entities/champion.dart';
import '../../data/repositories/composition_repository_impl.dart';
import '../../data/datasources/lol_api_datasource.dart';
import '../../core/dio/dio_provider.dart';

final compositionRepositoryProvider = Provider<CompositionRepository>((ref) {
  final dio = ref.read(dioProvider);
  final datasource = LolApiDatasource(dio);
  return CompositionRepositoryImpl(datasource, version: '');
});

final championsProvider = FutureProvider<List<Champion>>((ref) async {
  final dio = ref.read(dioProvider);
  final datasource = LolApiDatasource(dio);

  // Pega a versão mais recente
  final latestVersion = await datasource.getLatestVersion();

  final repository = CompositionRepositoryImpl(datasource, version: latestVersion);
  return repository.getChampions();
});
