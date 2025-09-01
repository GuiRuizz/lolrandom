import '../datasources/lol_items_datasource.dart';
import '../model/item_model.dart';
import 'item_repository.dart';

class ItemRepositoryImpl implements ItemRepository {
  final LolItemsDatasource datasource;

  ItemRepositoryImpl(this.datasource);

  @override
  Future<List<ItemModel>> getAllItems(String version) {
    return datasource.getItems(version);
  }
}
