import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:inven/models/item.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String itemTable = 'item_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colCategory = 'category';
  String colQuantity = 'quantity';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'items.db';

    var itemsDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return itemsDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $itemTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
        '$colDescription TEXT, $colCategory TEXT, $colQuantity TEXT)');
  }

  Future<List<Map<String, dynamic>>> getItemMapList() async {
    Database db = await this.database;

    var result = await db.query(itemTable);
    return result;
  }

  Future<List<Map<String, dynamic>>> getItemCatMapList(String category) async {
    Database db = await this.database;

    var result = await db
        .query(itemTable, where: '$colCategory = ?', whereArgs: [category]);
    return result;
  }

  Future<int> insertItem(Item item) async {
    Database db = await this.database;
    var result = await db.insert(itemTable, item.toMap());
    return result;
  }

  Future<int> updateItem(Item item) async {
    var db = await this.database;
    var result = await db.update(itemTable, item.toMap(),
        where: '$colId = ?', whereArgs: [item.id]);
    return result;
  }

  Future<int> deleteItem(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $itemTable WHERE $colId = $id');
    return result;
  }

  Future<List<Item>> getItemList() async {
    var itemMapList = await getItemMapList();
    int count = itemMapList.length;

    List<Item> itemList = List<Item>();

    for (int i = 0; i < count; i++) {
      itemList.add(Item.fromMapObject(itemMapList[i]));
    }

    return itemList;
  }

  Future<List<Item>> getItemCatList(String category) async {
    var itemMapList = await getItemCatMapList(category);
    int count = itemMapList.length;

    List<Item> itemList = List<Item>();

    for (int i = 0; i < count; i++) {
      itemList.add(Item.fromMapObject(itemMapList[i]));
    }

    return itemList;
  }
}
