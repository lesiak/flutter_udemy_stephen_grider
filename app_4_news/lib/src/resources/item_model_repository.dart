import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

class ItemModelRepository {
  NewsDbProvider dbProvider = NewsDbProvider();
  NewsApiProvider apiProvider = NewsApiProvider();

  Future<List<int>> fetchTopIds() {
    return apiProvider.fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel itemFromDb = await dbProvider.fetchItem(id);
    if (itemFromDb != null) {
      return itemFromDb;
    }

    ItemModel itemFromApi = await apiProvider.fetchItem(id);
    dbProvider.addItem(itemFromApi); // do not wait for adding to complete
    return itemFromApi;
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
}