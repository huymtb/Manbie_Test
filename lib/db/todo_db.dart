import 'dart:io';

import 'package:manabie_testing/model/todo.dart';
import 'package:manabie_testing/utils/constants.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class TodoDatabaseHelper {
  static const String _databaseName = 'Todo.db';
  static const int _databaseVersion = 1;

  // make this a singleton class
  TodoDatabaseHelper._privateConstructor();

  static final TodoDatabaseHelper instance =
      TodoDatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  Future<Database> _initDatabase() async {
    final Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    final String path = join(documentsDirectory.path, _databaseName);
    return openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE ${Constants.tableTodo} (
            ${Constants.columnId} INTEGER PRIMARY KEY,
            ${Constants.columnName} TEXT NOT NULL,
            ${Constants.columnContent} TEXT NOT NULL,
            ${Constants.columnStatus} INTEGER NOT NULL
          )
          ''');
  }

  // inserted row.
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(Constants.tableTodo, row,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // query all
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(Constants.tableTodo);
  }

  Future<Todo> getTodo(int id) async {
    Database db = await instance.database;
    List<Map> maps = await db.query(Constants.tableTodo,
        columns: [
          Constants.columnId,
          Constants.columnName,
          Constants.columnContent,
          Constants.columnStatus
        ],
        where: '${Constants.columnId} = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Todo.fromMap(maps.first);
    }
    return Todo();
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(Constants.tableTodo,
        where: '${Constants.columnId} = ?', whereArgs: [id]);
  }

  Future<int> update(Todo todo) async {
    final Database db = await instance.database;
    return db.update(Constants.tableTodo, todo.toMap(),
        where: '${Constants.columnId} = ?', whereArgs: [todo.id]);
  }
}
