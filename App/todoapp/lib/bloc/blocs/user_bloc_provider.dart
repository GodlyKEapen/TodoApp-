import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/bloc/blocs/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todoapp/models/classes/user.dart';
import 'package:todoapp/models/classes/task.dart';

class UserBloc {
  final _repository = Repository();
  final _userGetter = PublishSubject<User>();

  Observable<User> get getUser => _userGetter.stream;

  registerUser(String username, String firstname, String lastname,
      String emailadress, String password) async {
    User user = await _repository.registerUser(
        username, firstname, lastname, emailadress, password);
    _userGetter.sink.add(user);
  }

  signinUser(String username, String password, String apiKey) async {
    User user = await _repository.signinUser(username, password, apiKey);
    _userGetter.sink.add(user);
  }

  getUserTasks(String apiKey) async {
    User user = await _repository.getUserTasks(apiKey);
    _userGetter.sink.add(user);
  }

  dispose() {
    _userGetter.close();
  }
}

class TaskBloc {
  final _repository = Repository();
  final _taskSubject = BehaviorSubject<List<Task>>();
  String apiKey;

  var _tasks = <Task>[];

  TaskBloc(String api_key) {
    this.apiKey = api_key;
    _updateTasks(api_key).then((_) {
      _taskSubject.add(_tasks);
    });
  }

  Stream<List<Task>> get getTasks => _taskSubject.stream;
  String apikeys;
  Future<Null> _updateTasks(String apiKey) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    // apikeys = prefs.getString("API_Token");

    _tasks = await _repository.getUserTasks(apiKey);
  }
}

final userBloc = UserBloc();
