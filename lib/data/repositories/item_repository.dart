import '../model/item_model.dart';

abstract class ItemRepository {
  Future<List<ItemModel>> getAllItems(String version);
}
