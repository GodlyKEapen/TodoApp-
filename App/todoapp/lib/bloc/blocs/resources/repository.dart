import 'dart:async';
// import 'dart:js';
import 'package:flutter/cupertino.dart';

import 'api.dart';
import 'package:todoapp/models/classes/user.dart';

class Repository {
   final apiProvider = ApiProvider();

   Future<User> registerUser(String username, String firstname, String lastname, String emailadress, String password)
   => apiProvider.registerUser(username, firstname, lastname, emailadress, password);

   Future signinUser(String username,  String password, String apiKey)
   => apiProvider.signinUser(username, password, apiKey);

   Future getUserTasks(String apiKey)
   => apiProvider.getUserTasks(apiKey);

   Future<Null> addUserTask(String apiKey, String taskName, String deadline, BuildContext context) async {
     apiProvider.addUserTask(apiKey, taskName, deadline, context);
      }
}