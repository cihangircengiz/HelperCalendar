import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'globals.dart';
import 'package:flutter/widgets.dart';
class CoursePage extends StatefulWidget {
  @override
  _CoursePageState createState() => new _CoursePageState();
}
Query _query;
class _CoursePageState extends State<CoursePage> {
  @override
  void initState() {
    Database.queryCourses().then((Query query) {
      setState(() {
        _query = query;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: addButton,
      ),
      body: body(),
    );
  }
}
Widget body() {
  Widget body = new ListView(
    children: <Widget>[
      new ListTile(
        title: new Text("Courses Are Empty"),
      )
    ],
  );
  if(_query != null) {
    body = new FirebaseAnimatedList(
      query: _query,
      itemBuilder: (BuildContext context,
          DataSnapshot snapshot,
          Animation<double> animation,
          int index,) {
        Map map = snapshot.value;
        String name = map['course_name'] as String;
        String key = snapshot.key;  // for delete
        String classes = map['course_class'] as String;
        return new Column(
          children: <Widget>[
            new ListTile(
              subtitle: new Text('Classes : $classes'),
              title: new Text('$name'),
              onTap: null,
                onLongPress:(){
                  DeleteCourse('$key');
                }
            ),
            new Divider(
              height: 1.0,
            ),
          ],
        );
      },
    );
  }
  return body;
}
void addButton(){
  Database.addCourse("Calculus","M203","MATH 153");
}
void DeleteCourse(String x){
  //print(x);
  Database.deleteCourses(x);
}