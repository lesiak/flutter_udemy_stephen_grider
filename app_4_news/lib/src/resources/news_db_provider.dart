import 'dart:io';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import '../models/item_model.dart';
import 'package:app_4_news/src/resources/item_model_repository.dart';

class NewsDbProvider implements Source, Cache {
  Database db;

  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "items.db");
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute('''
          CREATE TABLE Items
          (
            id INTEGER PRIMARY KEY,
            type TEXT,
            by TEXT,
            time INTEGER,
            text TEXT,
            parent INTEGER,
            kids BLOB,
            dead INTEGER,
            deleted INTEGER,
            url TEXT,
            score INTEGER,
            title TEXT,
            descendants INTEGER
          );
        ''');
      },
    );
  }

  @override
  Future<List<int>> fetchTopIds() {
    //TODO: store and fetch top ids
    return null;
  }

  Future<ItemModel> fetchItem(int id) async {
    List<Map<String, dynamic>> maps = await db.query(
      'Items',
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return ItemModel.fromDb(maps.first);
    }

    return null;
  }

  Future<int> addItem(ItemModel item) {
    return db.insert(
      'Items',
      item.toMapForDb(),
    );
  }
}
