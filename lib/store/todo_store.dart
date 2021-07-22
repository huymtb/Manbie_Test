import 'package:manabie_testing/model/todo.dart';
import 'package:manabie_testing/repository/todo_repository.dart';
import 'package:mobx/mobx.dart';

part 'todo_store.g.dart';

class TodoStore = _TodoStore with _$TodoStore;

abstract class _TodoStore with Store {
  final TodoRepository _todoRepository = TodoRepository();

  @observable
  bool isShowLoading = false;

  @observable
  ObservableList<Todo> listTodo = ObservableList();

  @observable
  ObservableList<Todo> listDone = ObservableList();

  @observable
  ObservableList<Todo> listNotDone = ObservableList();

  @observable
  int pagePosition = 0;

  @computed
  bool get hasCompletedTodo => listDone.isNotEmpty;

  @computed
  bool get hasInCompletedTodo => listNotDone.isNotEmpty;

  @computed
  String get calculateData {
    if (listTodo.isEmpty) {
      return "There are no Todos here. Why don't you add one?.";
    }

    final suffix = listNotDone.length == 1 ? 'todo' : 'todos';
    return '${listNotDone.length} pending $suffix, ${listDone.length} completed';
  }

  set jumpToOtherPage(int value) {
    pagePosition = value;
  }

  int get jumpToOtherPage => pagePosition;

  @action
  Future<void> getAllTodo() async {
    isShowLoading = true;
    final List<Todo> list = await _todoRepository.getAllTodo();
    listTodo.addAll(list);
    for (final Todo todo in listTodo) {
      if (todo.status!) {
        listDone.add(todo);
      } else {
        listNotDone.add(todo);
      }
    }

    isShowLoading = false;
  }

  @action
  void insertTodoToList(Todo todo) {
    listTodo.insert(listTodo.length, todo);
  }

  @action
  Future<void> updateTodo(Todo todo) async {
    todo.status = !todo.status!;
    await _todoRepository.checkDoneTodo(todo);
    if (todo.status!) {
      listDone.add(todo);
      listNotDone.removeWhere((element) => element.id == todo.id);
    } else {
      listNotDone.add(todo);
      listDone.removeWhere((element) => element.id == todo.id);
    }
    for (int i = 0; i < listTodo.length; i++) {
      if (listTodo[i].id == todo.id) {
        listTodo.removeAt(i);
        listTodo.insert(i, todo);
      }
    }
  }
}

/// Build (generate .g.dart) flutter packages pub run build_runner build
/// Watch (update .g.dart automatically)
/// flutter packages pub run build_runner watch
/// Clean before updating:
/// flutter packages pub run build_runner watch --delete-conflicting-outputs
