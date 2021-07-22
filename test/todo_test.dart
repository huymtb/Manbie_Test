import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:manabie_testing/model/todo.dart';
import 'package:manabie_testing/store/todo_store.dart';

void main() {
  late TodoStore todoStore;

  setUp(() {
    todoStore = TodoStore();
  });

  test('Parse json and add to list', () async {
    expect(todoStore.listTodo.length, equals(0));
    const targetJson = '''
    [
        {
          "_id" : 1,
          "name": "Python",
          "content": "31.43 %",
          "status": 0
        },
        {
          "_id" : 2,
          "name": "Java",
          "content": "13.16 %",
          "status": 0
        }
      ]
''';
    final listJson = json.decode(targetJson);
    for (final Map<String, dynamic> data in listJson) {
      todoStore.listTodo.add(Todo.fromMap(data));
      todoStore.listNotDone.add(Todo.fromMap(data));
    }
    expect(listJson.length, todoStore.listTodo.length);
    expect(todoStore.listTodo[0].id, 1);
    expect(todoStore.hasCompletedTodo, isFalse);
    expect(todoStore.hasInCompletedTodo, isTrue);
    expect(todoStore.calculateData, equals('2 pending todos, 0 completed'));
  });

  test('Change status todo', () {
    expect(todoStore.listTodo.length, equals(0));
    const targetJson = '''
    [
        {
          "_id" : 1,
          "name": "Python",
          "content": "31.43 %",
          "status": 0
        },
        {
          "_id" : 2,
          "name": "Java",
          "content": "13.16 %",
          "status": 1
        }
      ]
''';
    final listJson = json.decode(targetJson);
    for (final Map<String, dynamic> data in listJson) {
      todoStore.listTodo.add(Todo.fromMap(data));
    }
    for (final Todo todo in todoStore.listTodo) {
      if (todo.status!) {
        todoStore.listDone.add(todo);
      } else {
        todoStore.listNotDone.add(todo);
      }
    }

    expect(listJson.length, todoStore.listTodo.length);
    expect(todoStore.listTodo[0].id, 1);
    expect(todoStore.hasCompletedTodo, isTrue);
    expect(todoStore.hasInCompletedTodo, isTrue);
    expect(todoStore.calculateData, equals('1 pending todo, 1 completed'));
  });
}