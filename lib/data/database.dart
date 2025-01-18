import 'package:hive/hive.dart';

class ToDoDatabase {
  List todoList = [];

  final _myBox = Hive.box('myBox');

  void createInitialData() {
    todoList = [
      ['Add Tasks', false],
    ];
  }

  void updateData() {
    _myBox.put('TODOLIST', todoList);
  }

  void getData() {
    todoList = _myBox.get('TODOLIST');
  }
}
