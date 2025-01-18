import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final bool isDone;
  Function(bool?)? onCheckboxChanged;
  VoidCallback? deleteTask;

  TodoTile({
    super.key,
    required this.taskName,
    required this.isDone,
    required this.onCheckboxChanged,
    required this.deleteTask,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.yellow[400],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Checkbox(
              value: isDone,
              onChanged: onCheckboxChanged,
              activeColor: Colors.black,
            ),
            Text(
              taskName,
              style: TextStyle(
                fontSize: 18,
                decoration: isDone ? TextDecoration.lineThrough : null,
              ),
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: deleteTask,
            ),
          ],
        ),
      ),
    );
  }
}
