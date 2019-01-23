import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:app_4_news/src/resources/news_api_provider.dart';

void main() {
  test('fetchTopIds returns a list of ids', () async {
    Client client = MockClient((Request request) async {
      return Response(json.encode([1, 2, 3, 4]), 200);
    });
    final newsApi = NewsApiProvider(client);
    final ids = await newsApi.fetchTopIds();
    expect(ids, [1, 2, 3, 4]);
  });

  test('fetchItem returns an ItemModel', () async {
    Client client = MockClient((Request request) async {
      final jsonMap = {'id': 123};
      return Response(json.encode(jsonMap), 200);
    });
    final newsApi = NewsApiProvider(client);
    final item = await newsApi.fetchItem(999);
    expect(item.id, 123);
  });
}
