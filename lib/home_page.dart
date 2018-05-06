import 'package:flutter/material.dart';
import 'classes.dart';
class HomePage extends StatelessWidget{
  static String tag = "home-page";
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new DefaultTabController(
        length: 2,
        child: new Scaffold(
          appBar: new AppBar(
            bottom: new TabBar(
              tabs: [
                new Tab(icon: new Icon(Icons.class_)),
                new Tab(icon: new Icon(Icons.alarm)),
              ],
            ),
            title: new Text("HelperCalendar 1.0"),
          ),
          body: new TabBarView(
            children: [
              CoursePage(),
              new Icon(Icons.directions_transit),
            ],
          ),
        ),
      ),
    );
  }
void addClass(){
   // globals.Database.addCourse();
}
}