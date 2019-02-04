import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/item_model_repository.dart';

class StoriesBloc {
  final _repository = ItemModelRepository();

  final _topIds = PublishSubject<List<int>>();

  //Getters to Streams
  Observable<List<int>> get topIds => _topIds.stream;

  void fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  void dispose() {
    _topIds.close();
  }
}
