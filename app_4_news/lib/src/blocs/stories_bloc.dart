import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/item_model_repository.dart';

class StoriesBloc {
  final _repository = ItemModelRepository();
  final _topIds = PublishSubject<List<int>>();
  final _itemsFetcher = PublishSubject<int>();
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  
  //Getters to Streams
  Observable<List<int>> get topIds => _topIds.stream;

  Observable<Map<int, Future<ItemModel>>> get items => _itemsOutput.stream;

  // Getters to sinks
  Function(int) get fetchItem => _itemsFetcher.sink.add;

  StoriesBloc() {
    _itemsFetcher.stream.transform(_itemsTransformer()).pipe(_itemsOutput);
  }

  void fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  StreamTransformer<int, Map<int, Future<ItemModel>>> _itemsTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
      (Map<int, Future<ItemModel>> cache, int id, int index) {
        print(index);
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  void dispose() {
    _topIds.close();
    _itemsFetcher.close();
    _itemsOutput.close();
  }
}
