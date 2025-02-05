import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static DbHelper? _instance;

  static DbHelper get instance => _instance ??= DbHelper._init();

  DbHelper._init() {
    _initDb();
  }

  Database? _db;

  Future<Database> get db async {
    _db ??= await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "tasks.db");
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE tasks (id INTEGER PRIMARY KEY AUTOINCREMENT, userId INTEGER, title TEXT, description TEXT, due_date TEXT, status TEXT, priority TEXT, completed INTEGER DEFAULT 0, synced INTEGER DEFAULT 0, created_date TEXT DEFAULT CURRENT_TIMESTAMP, sync_id INTEGER DEFAULT 0, deleted INTEGER DEFAULT 0)');
  }

  Future deleteDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "tasks.db");
    await deleteDatabase(path);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }

  Future<int> insert(Map<String, dynamic> row) async {
    row.remove('id');
    var dbClient = await db;
    row.updateAll((key, value) => value is bool ? (value ? 1 : 0) : value);
    final res = await dbClient.insert('tasks', row);
    return res;
  }

  Future<List<dynamic>> queryAllRows(bool unsynced,
      {int? limit, int? page}) async {
    Database? dbClient = await db;
    if (unsynced) {
      final data =
          await dbClient.query('tasks', where: "synced = ?", whereArgs: [0]);
      return [data.length, data as List<Map<String, dynamic>>];
    }
    final res =
        await dbClient.query('tasks', where: "deleted = ?", whereArgs: [0]);
    final resOff = await dbClient.query('tasks',
        where: "deleted = ?", whereArgs: [0], limit: limit, offset: page);
    return [res.length, resOff];
  }

  Future<List<Map<String, dynamic>>> querySingleRows(int id) async {
    Database? dbClient = await db;
    return await dbClient.query('tasks',
        where: "id = ?", whereArgs: [id], limit: 1);
  }

  Future<int> update(Map<String, dynamic> row) async {
    var dbClient = await db;
    int id = row['id'];
    row.updateAll(
        (key, value) => value is bool ? (value ? 1 : 0) : value as Object);
    return await dbClient
        .update('tasks', row, where: "id = ?", whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete('tasks', where: "id = ?", whereArgs: [id]);
  }

  Future<int> syncRows(List<Map<String, dynamic>> rows) async {
    var dbClient = await db;
    for (var row in rows) {
      row['synced'] = 1;
      final res = await dbClient
          .query('tasks', where: "sync_id = ?", whereArgs: [row['id']]);
      if (res.isNotEmpty) continue;
      await dbClient.insert('tasks', row);
    }
    return rows.length;
  }

  Future<int> sync(int id, int syncId) async {
    var dbClient = await db;
    final res = await dbClient.query('tasks', where: "id = ?", whereArgs: [id]);
    if (res.first['deleted'] == 1) {
      await dbClient.delete('tasks', where: "id = ?", whereArgs: [id]);
      return 0;
    }

    return await dbClient.update('tasks', {'synced': 1, 'sync_id': syncId},
        where: "id = ?", whereArgs: [id]);
  }
}
