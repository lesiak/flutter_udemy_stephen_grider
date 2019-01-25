import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:app_4_news/src/resources/item_model_repository.dart';
import '../models/item_model.dart';

class NewsApiProvider implements Source {
  final _apiRoot = 'https://hacker-news.firebaseio.com/v0';
  Client client = Client();

  NewsApiProvider([Client client]) {
    this.client = (client != null) ? client : Client();
  }

  Future<List<int>> fetchTopIds() async {
    final response = await client.get('$_apiRoot/topstories.json');
    final ids = json.decode(response.body);
    return ids.cast<int>();
  }

  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get('$_apiRoot/item/$id.json');
    final parsedJson = json.decode(response.body);
    return ItemModel.fromJson(parsedJson);
  }
}
