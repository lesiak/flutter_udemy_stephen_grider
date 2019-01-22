import 'dart:convert';
import 'package:http/http.dart' show Client;
import '../models/item_model.dart';

class NewsApiProvider {
  final _apiRoot = 'https://hacker-news.firebaseio.com/v0';
  final Client client = Client();

  fetchTopIds() async {
    final response = await client.get('$_apiRoot/topstories.json');
    final ids = json.decode(response.body);
    return ids;
  }

  fetchItem(int id) async {
    final response = await client.get('$_apiRoot/item/$id.json');
    final parsedJson = json.decode(response.body);
    return ItemModel.fromJson(parsedJson);
  }
}
