import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

class ItemModelRepository {
  final NewsDbProvider newsDbProvider = NewsDbProvider();

  List<Source> sources;

  List<Cache> caches;

  ItemModelRepository() {
    newsDbProvider.init();

    sources = <Source>[
      newsDbProvider,
      NewsApiProvider(),
    ];

    caches = <Cache>[
      newsDbProvider,
    ];
  }

  // TODO: Iterate over sources when newsDbProvider get fetchTopIds implemented
  Future<List<int>> fetchTopIds() {
    return sources[1].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    for (Source source in sources) {
      ItemModel item = await source.fetchItem(id);
      if (item != null) {
        for (var cache in caches) {
          if (cache != source) {
            cache.addItem(item);
          }
        }
        return item;
      }
    }
    return null;
  }

  Future<void> clearCache() async {
    for (Cache cache in caches) {
      await cache.clear();
    }
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();

  Future<ItemModel> fetchItem(int id);
}

abstract class Cache extends Source {
  Future<int> addItem(ItemModel item);

  Future<int> clear();
}

final ItemModelRepository itemModelRepositoryInstance = ItemModelRepository();