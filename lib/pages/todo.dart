import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo/components/dialog_box.dart';
import 'package:todo/components/todo_tile.dart';
import 'package:todo/data/database.dart';

class ToDo extends StatefulWidget {
  const ToDo({super.key});

  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  final _myBox = Hive.box('myBox');
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    if (_myBox.get('TODOLIST') == null) {
      db.createInitialData();
      db.updateData();
    } else {
      db.getData();
    }

    super.initState();
  }

  final _controller = TextEditingController();

  void onCheckboxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateData();
  }

  void addTask() {
    setState(() {
      db.todoList.add([_controller.text, false]);
      _controller.clear();
    });
    db.updateData();
    Navigator.pop(context);
  }

  void onCancel() {
    setState(() {
      _controller.clear();
    });
    Navigator.pop(context);
  }

  void openDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: addTask,
            onCancel: onCancel,
          );
        });
  }

  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TO DO',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openDialog();
        },
        backgroundColor: Colors.yellow[600],
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.yellow[200],
      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: db.todoList[index][0],
            isDone: db.todoList[index][1],
            onCheckboxChanged: (value) => onCheckboxChanged(value, index),
            deleteTask: () => deleteTask(index),
          );
        },
      ),
    );
  }
}
