import 'package:flutter/material.dart';
import 'home_page.dart';
import 'login_page.dart';
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  final routes = <String,WidgetBuilder>{
    LoginPage.tag:(context) => LoginPage(),
    HomePage.tag:(context) => HomePage(),
  };
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: LoginPage(),
        routes: routes,
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        )
    );
  }
}
