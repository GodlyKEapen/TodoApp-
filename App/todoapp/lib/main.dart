//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/global.dart';
import 'UI/Intray/Intray_page.dart';
import 'package:todoapp/UI/Login/loginscreen.dart';
import 'package:http/http.dart' as http;
import 'package:todoapp/models/classes/user.dart';
import 'package:todoapp/bloc/blocs/user_bloc_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo App',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: MyHomePage()

        // home: FutureBuilder(
        //
        //         );
        //       },
        //     ); // unreachable
        //   },
        // ),
        );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getApikey(),
      builder: (BuildContext conntext, AsyncSnapshot snapshot) {
        String apiKey = "";
        if (snapshot.hasData) {
          apiKey = snapshot.data;
          // print("ApiKey\n\n\n" + snapshot.data);
          // print("There is Data");
        } else {
          print("No Data");
        }
        // String apiKey = snapshot.data;
        // apiKey.length > 0 ? getHomePage() :
        return apiKey.length > 0
            ? getHomePage()
            : LoginPage(
                login: login,
                newUser: false,
              );
      },
    );
  }

  void login() {
    setState(() {
      build(context);
    });
  }

  // void signupPressed() {
  //   setState(() {
  //     build(context);
  //   });
  // }

  Future getApikey() async {
    // print("Hello");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print(prefs.containsKey("API_Token"));
    return await prefs.getString("API_Token");
  }

  Widget getHomePage() {
    return MaterialApp(
      color: Colors.yellow,
      home: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: new Scaffold(
            body: Stack(
              children: <Widget>[
                TabBarView(
                  children: [
                    IntrayPage(),
                    new Container(
                      color: Colors.grey,
                    ),
                    new Container(
                      child: Center(
                        child: FlatButton(
                            color: redColor,
                            child: Text("LogOut"),
                            onPressed: () {
                              logout();
                            }),
                      ),
                      color: Colors.deepPurpleAccent,
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 50),
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Intray",
                        style: intrayTitleStyle,
                      ),
                      Container()
                    ],
                  ),
                ),
                Container(
                  height: 70,
                  width: 70,
                  margin: EdgeInsets.only(top: 130, left: 170),
                  child: FloatingActionButton(
                    child: Icon(
                      Icons.add,
                      size: 50,
                    ),
                    backgroundColor: redColor,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            appBar: AppBar(
              elevation: 0,
              title: new TabBar(
                  tabs: [
                    Tab(
                      icon: new Icon(Icons.home),
                    ),
                    Tab(
                      icon: new Icon(Icons.rss_feed),
                    ),
                    Tab(
                      icon: new Icon(Icons.perm_identity),
                    ),
                  ],
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black87,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorPadding: EdgeInsets.all(5.0),
                  indicatorColor: Colors.transparent),
              backgroundColor: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("Api_Token", "");
    setState(() {
      build(context);
    });
  }

  @override
  void initState() {
    super.initState();
  }
}
