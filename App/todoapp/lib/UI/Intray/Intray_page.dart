import 'package:flutter/material.dart';
import 'package:todoapp/models/Widgets/Intray_todo_widget.dart';
import 'package:todoapp/models/classes/todoItem.dart';
import 'package:todoapp/models/global.dart';
import 'package:todoapp/bloc/blocs/user_bloc_provider.dart';

class IntrayPage extends StatefulWidget {
  final String apiKey;
  IntrayPage({this.apiKey});
  @override
  _IntrayPageState createState() => _IntrayPageState();
}

class _IntrayPageState extends State<IntrayPage> {
  List<Task> taskList = [];
  TaskBloc tasksBloc;
  // TaskBloc tasksBloc;
  @override
  void initState() {
    tasksBloc = TaskBloc(widget.apiKey);
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // taskList = getList();
    return Container(
        padding: EdgeInsets.only(top: 250),
        color: darkGreyColor,
        child: StreamBuilder(
            stream: tasksBloc.getTasks,
            initialData: [],
            // List<Task>(),
            builder: (context, snapshot) {
              taskList = snapshot.data;
              return _buildReorderableListSimple(context, taskList);
            })

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

  Widget _buildReorderableListSimple(BuildContext context, List<Task> item) {
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

  // FutureList<Task> getList() async {
  //   List<Task> tasks = await tasksBloc.getUserTasks(widget.apiKey);
  //   return tasks;
  // }
}
