import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:manabie_testing/db/todo_db.dart';
import 'package:manabie_testing/model/todo.dart';
import 'package:manabie_testing/utils/local_storage.dart';

class TodoRepository {
  final TodoDatabaseHelper _todoDBHelper = TodoDatabaseHelper.instance;

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('lib/res/file/todo_list.json');
    final allData = await json.decode(response);

    for (final Map<String, dynamic> data in allData['todo']) {
      await _todoDBHelper.insert(data);
    }
    LocalStorage.setBool(LocalStorage.SAVE_DATA, status: true);
  }

  Future<List<Todo>> getAllTodo() async {
    final bool isSaveData = await LocalStorage.getBool(LocalStorage.SAVE_DATA);
    if (!isSaveData) {
      await readJson();
    }
    final allRows = await _todoDBHelper.queryAllRows();
    final List<Todo> todo = <Todo>[];
    for (final Map<String, dynamic> row in allRows) {
      todo.add(Todo.fromMap(row));
    }
    return todo;
  }

  Future<int> checkDoneTodo(Todo todo) async {
    return _todoDBHelper.update(todo);
  }
}
