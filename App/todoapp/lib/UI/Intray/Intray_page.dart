import 'package:flutter/material.dart';
import 'package:todoapp/models/Widgets/Intray_todo_widget.dart';
import 'package:todoapp/models/classes/todoItem.dart';
import 'package:todoapp/models/global.dart';

class IntrayPage extends StatefulWidget {
  @override
  _IntrayPageState createState() => _IntrayPageState();
}

class _IntrayPageState extends State<IntrayPage> {
  List<Task> taskList = [];
  @override
  Widget build(BuildContext context) {
    taskList = getList();
    return Container(
      padding: EdgeInsets.only(top: 250),
      color: darkGreyColor,
      child: _buildReorderableListSimple(context),
      //child: ReorderableListView(
      //  children: todoItems,
      //  onReorder: _onReorder,
      // ),
    );
  }

  Widget _buildListTile(BuildContext context, Task item) {
    return ListTile(
      key: Key(item.taskId),
      title: IntrayTodo(
        title: item.title,
      ),
    );
  }

  Widget _buildReorderableListSimple(BuildContext context) {
    return Theme(
      data: ThemeData(canvasColor: Colors.transparent),
      child: ReorderableListView(
          // allowReordering: _reordering,
          padding: EdgeInsets.only(top: 300),
          children: taskList
              .map((Task item) => _buildListTile(context, item))
              .toList(),
          onReorder: (oldIndex, newIndex) {
            setState(() {
              Task item = taskList[oldIndex];
              taskList.remove(item);
              taskList.insert(newIndex, item);
            });
          }),
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final Task item = taskList.removeAt(oldIndex);
      taskList.insert(newIndex, item);
    });
  }

  List<Task> getList() {
    for (int i = 0; i < 100; i++) {
      taskList.add(Task("Hello" + i.toString(), false, i.toString()));
    }
    return taskList;
  }
}
