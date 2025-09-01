import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/dio/dio_provider.dart';
import '../../data/datasources/lol_items_datasource.dart';
import '../../data/datasources/lol_api_datasource.dart';
import '../../data/repositories/item_repository.dart';
import '../../data/repositories/item_repository_impl.dart';
import '../../data/model/item_model.dart';

// Provider do datasource de itens
final lolItemsDatasourceProvider = Provider<LolItemsDatasource>((ref) {
  final dio = ref.read(dioProvider);
  return LolItemsDatasource(dio);
});

// Provider do repository
final itemRepositoryProvider = Provider<ItemRepository>((ref) {
  final datasource = ref.read(lolItemsDatasourceProvider);
  return ItemRepositoryImpl(datasource);
});

// Provider para buscar todos os itens
final itemsProvider = FutureProvider<List<ItemModel>>((ref) async {
  final repository = ref.read(itemRepositoryProvider);
  final dio = ref.read(dioProvider);
  final lolApiDatasource = LolApiDatasource(dio);

  final latestVersion = await lolApiDatasource.getLatestVersion();
  return repository.getAllItems(latestVersion);
});
