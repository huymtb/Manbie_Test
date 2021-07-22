import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:manabie_testing/model/todo.dart';
import 'package:manabie_testing/res/file/strings.dart';
import 'package:manabie_testing/store/todo_store.dart';
import 'package:manabie_testing/widget/app_bar.dart';
import 'package:manabie_testing/widget/no_todo_item.dart';
import 'package:manabie_testing/widget/todo_item.dart';

class CompleteTodoScreen extends StatelessWidget {
  final TodoStore? todoStore;

  const CompleteTodoScreen({Key? key, this.todoStore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppBarWidget(
          title: AppText.completeTitle,
        ),
        Expanded(child: Observer(
          builder: (context) {
            return _buildListTodo();
          },
        ))
      ],
    );
  }

  Widget _buildListTodo() {
    if (todoStore!.listDone.isEmpty) {
      return const NoTodoItem();
    }
    return ListView.builder(
        itemCount: todoStore!.listDone.length,
        itemBuilder: (context, index) {
          final Todo todo = todoStore!.listDone[index];
          return TodoItem(
            todo: todoStore!.listDone[index],
            checkDone: () {
              todoStore!.updateTodo(todo);
            },
          );
        });
  }
}
