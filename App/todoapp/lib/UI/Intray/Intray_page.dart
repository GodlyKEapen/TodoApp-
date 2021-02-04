import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/models/classes/task.dart';
import 'package:todoapp/models/global.dart';
import 'package:todoapp/models/widgets/intray_todo_widget.dart';
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
  
  String apikey;
  getpref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      apikey = prefs.getString("API_Token");
      tasksBloc = TaskBloc(apikey);
    });
  }

  @override
  void initState() {
    getpref();
    //  tasksBloc = TaskBloc(widget.apiKey);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
        color: darkGreyColor,
        child: StreamBuilder(
          stream: tasksBloc.getTasks,
          initialData: [],
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot != null) {
              if (snapshot.data.length > 0) {
                return _buildReorderableListSimple(context, snapshot.data);
              } else if (snapshot.data.length == 0) {
                return Center(child: Text("No Data"));
              }
            } else if (snapshot.hasError) {
              return Container();
            }
            return CircularProgressIndicator();
          },
        )
        // child: ReorderableListView(
        //   padding: EdgeInsets.only(top: 300),
        // children: getList(),
        // onRecorder: _onRecorder,
        // ),
        );
  }

  Widget _buildListTile(BuildContext context, Task item) {
    return ListTile(
      key: Key(item.taskId.toString()),
      title: IntrayTodo(
        title: item.title,
      ),
    );
  }

  Widget _buildReorderableListSimple(
      BuildContext context, List<Task> taskList) {
    print(taskList.length);
    return Theme(
        data: ThemeData(canvasColor: Colors.transparent),
        child: ReorderableListView(
          padding: EdgeInsets.only(top: 300.0),
          children: taskList
              .map((Task item) => _buildListTile(context, item))
              .toList(),
          onReorder: (oldIndex, newIndex) {
            setState(() {
              Task item = taskList[oldIndex];
              taskList.remove(item);
              taskList.insert(newIndex, item);
            });
          },
        ));
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
  // Future<List<Task>> getList()  async {
  //   List<Task> tasks = await tasksBloc.getUserTasks(widget.apiKey);
  //    return tasks;
  //
  // }
}

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:todoapp/models/classes/task.dart';
// import 'package:todoapp/models/global.dart';
// import 'package:todoapp/models/widgets/intray_todo_widget.dart';
// import 'package:todoapp/bloc/blocs/user_bloc_provider.dart';

// class IntrayPage extends StatefulWidget {
//   final String apiKey;
//   IntrayPage({this.apiKey});
//   @override
//   _IntrayPageState createState() => _IntrayPageState();
// }

// class _IntrayPageState extends State<IntrayPage> {
//   List<Task> taskList = [];
//   TaskBloc tasksBloc;
//   // @override
//   // void initState() {
//   //   setState(() {
//   //
//   //   });
//   // }
//   String apikey;
//   getpref() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       apikey = prefs.getString("API_Token");
//       tasksBloc = TaskBloc(apikey);
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     getpref();

//     // tasksBloc = TaskBloc(widget.apiKey);

//     print("sample");
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   Widget build(BuildContext context) {
//     return Container(
//         color: darkGreyColor,
//         child: StreamBuilder(
//           stream: tasksBloc.getTasks,
//           // initialData: [],
//           builder: (context, snapshot) {
//             print(snapshot);

//             if (snapshot.hasData && snapshot != null) {
//               if (snapshot.data.length > 0) {
//                 return _buildReorderableListSimple(context, snapshot.data);
//               } else if (snapshot.data.length == 0) {
//                 return Center(child: Text("Area 51"));
//               }
//             } else if (snapshot.hasError) {
//               return Container();
//             }
//             return CircularProgressIndicator();
//           },
//         )
//         // child: ReorderableListView(
//         //   padding: EdgeInsets.only(top: 300),
//         // children: getList(),
//         // onRecorder: _onRecorder,
//         // ),
//         );
//   }

//   Widget _buildListTile(BuildContext context, Task item) {
//     return ListTile(
//       key: Key(item.taskId.toString()),
//       title: IntrayTodo(
//         title: item.title,
//       ),
//     );
//   }

//   Widget _buildReorderableListSimple(
//       BuildContext context, List<Task> taskList) {
//     print(taskList.length);
//     return Theme(
//         data: ThemeData(canvasColor: Colors.transparent),
//         child: ReorderableListView(
//           padding: EdgeInsets.only(top: 300.0),
//           children: taskList
//               .map((Task item) => _buildListTile(context, item))
//               .toList(),
//           onReorder: (oldIndex, newIndex) {
//             setState(() {
//               // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>))
//               Task item = taskList[oldIndex];
//               taskList.remove(item);
//               taskList.insert(newIndex, item);
//             });
//           },
//         ));
//   }

//   void _onReorder(int oldIndex, int newIndex) {
//     setState(() {
//       if (newIndex > oldIndex) {
//         newIndex -= 1;
//       }
//       final Task item = taskList.removeAt(oldIndex);
//       taskList.insert(newIndex, item);
//     });
//   }
//   // Future<List<Task>> getList()  async {
//   //   List<Task> tasks = await tasksBloc.getUserTasks(widget.apiKey);
//   //    return tasks;
//   //
//   // }
// }
