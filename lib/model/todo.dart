import 'package:manabie_testing/utils/constants.dart';

class Todo {
  int? id;
  String? name;
  String? content;
  bool? status;

  Map<String, Object?> toMap() {
    final map = <String, Object?>{
      Constants.columnName: name,
      Constants.columnContent: content,
      Constants.columnStatus: status == true ? 1 : 0
    };
    if (id != null) {
      map[Constants.columnId] = id;
    }
    return map;
  }

  Todo();

  Todo.fromMap(Map<dynamic, dynamic> map) {
    id = map[Constants.columnId] as int;
    name = map[Constants.columnName] as String;
    content = map[Constants.columnContent] as String;
    status = map[Constants.columnStatus] == 1;
  }
}