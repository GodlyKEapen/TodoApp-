import 'package:flutter/widgets.dart';
import 'package:todoapp/models/classes/task.dart';

import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todoapp/models/classes/user.dart';

class UserBloc {
  final _repository = Repository();
  final _userGetter = PublishSubject<User>();

  Observable<User> get getuser => _userGetter.stream;

  registerUser(String username, String firstname, String lastname,
      String password, String email) async {
    User user = await _repository.registerUser(
        username, firstname, lastname, password, email);
    _userGetter.sink.add(user);
  }

  signinUser(
    String username,
    String password,
  ) async {
    User user = await _repository.signinUser(username, password);
    _userGetter.sink.add(user);
  }

  dispose() {
    _userGetter.close();
  }
}

class TaskBloc {
  // final _repository = Repository();
  // final _taskGetter = PublishSubject<List<Task>>();
  final _taskSubject = BehaviorSubject<List<Task>>();

  var _tasks = <Task>[];

  TaskBloc() {
    _updateTasks().then((_) {
      _taskSubject.add(_tasks);
    });
  }
  Future<Null> _updateTasks() {
    
  }
  Stream<List<Task>> get tasks => _taskSubject.stream;

  Observable<List<Task>> get getTasks => _taskGetter.stream;

  
  Future<List<Task>> getUserTasks(String apiKey) async {
    List<Task> tasks = await _repository.getUserTasks(apiKey);
    _taskGetter.sink.add(tasks);
    // return tasks;
  }
}

  dispose() {
    _taskGetter.close();
  }
}

final userbloc = UserBloc();
final tasksBloc = TaskBloc();
