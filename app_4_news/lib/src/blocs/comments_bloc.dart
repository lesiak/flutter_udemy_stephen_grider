import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../resources/item_model_repository.dart';
import '../models/item_model.dart';

class CommentsBloc {
  final _repository = itemModelRepositoryInstance;
  final _commentFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  // Streams
  Observable<Map<int, Future<ItemModel>>> get itemWithComments =>
      _commentsOutput.stream;

  // Sink
  Function(int) get fetchItemWithComments => _commentFetcher.sink.add;

  CommentsBloc() {
    _commentFetcher.stream
        .transform(_commentsTransformer())
        .pipe(_commentsOutput);
  }

  StreamTransformer<int, Map<int, Future<ItemModel>>> _commentsTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
        (Map<int, Future<ItemModel>> cache, int id, int index) {
          print('fetching details idx: $index');
          cache[id] = _repository.fetchItem(id);
          cache[id].then((ItemModel item) {
            item.kids.forEach((kidId) => fetchItemWithComments(kidId));
          });
          return cache;
        },
        <int, Future<ItemModel>> {}
    );
  }

  dispose() {
    _commentFetcher.close();
    _commentsOutput.close();
  }
}
