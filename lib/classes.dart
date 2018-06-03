import 'dart:async';
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
var days = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"];
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
    DateTime _today = new DateTime.now();
    return new Scaffold(
      appBar: new AppBar(title: new Text(days[_today.weekday]),backgroundColor: new Color(1),),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new addCourse()));
        },
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

////// Add CourseScreen

class addCourse extends StatefulWidget {
  @override
  addCourseState createState() {
    return new addCourseState();
  }
}

class addCourseState extends State<addCourse> {
  DateTime _date = new DateTime(2018);
  TimeOfDay _time = new TimeOfDay(hour: 09, minute: 00);

  static final TextEditingController _courseName = new TextEditingController();
  static final TextEditingController _courseClass = new TextEditingController();
  static final TextEditingController _courseCount = new TextEditingController();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(context: context,
        initialDate: _date, firstDate: new DateTime(2018), lastDate: new DateTime(2019)
    );
    if(picked != null && picked != _date) {
      setState(() {
        _date = picked;
      });
      print("Date selected: ${days[_date.weekday%7]}");
    }
  }
  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(context: context, initialTime: _time);
    if(picked !=null && picked !=_time){
      setState(() {
        _time = picked;
      });
      print(_time.hour+(_time.minute/100));
    }
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Add Course Screen"),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.save), onPressed: () {
            Database.addCourse(_courseName.text,_courseClass.text,days[_date.weekday%7],_time.hour+(_time.minute/100),_courseCount.toString());
            Navigator.pop(context);

          })
        ],
      ),
      body: new Center(
        child: new Column(
          children: <Widget>[
            new TextField(
              decoration:  new InputDecoration(
                hintText: "Course Name",
              ),
              controller: _courseName,
            ),
            new TextField(
              decoration: new InputDecoration(
                hintText: "Course Class"
              ),
              controller: _courseClass,
            ),
            new Row(
              children: <Widget>[
                new Text("Day Selected: ${days[_date.weekday%7]}"),
                new Container(width: 15.0),
                new RaisedButton(child:new Text("Select Date"),onPressed: (){_selectDate(context);}),
              ],
              mainAxisAlignment: MainAxisAlignment.end,
            ),
            new Row(
              children: <Widget>[
                new Text("Start Time: "+ _time.hour.toString()+":"+_time.minute.toString()),
                new Container(width: 15.0),
                new RaisedButton(child:new Text("Select Time"),onPressed: (){_selectTime(context);}),
              ],
              mainAxisAlignment: MainAxisAlignment.end,
            ),
            new TextField(
              decoration: new InputDecoration(
                hintText: "Course Count on these day",
              ),
              keyboardType: TextInputType.number,
              controller: _courseCount,
            )
          ],
        ),
      ),
    );
  }
}

void DeleteCourse(String x){
  print(x);
  Database.deleteCourses(x);
}