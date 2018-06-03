library my_prj.globals;
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

bool isLoggedIn = false;
FirebaseUser LoginedUser;
DateTime today = new DateTime.now();
var days = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"];
class Database {
  static Future<String> addCourse(String name,class_name,day_name,double time,String count) async {
    var user_course = <String, dynamic>{
      'course_name': name,
      'course_class': class_name,
      'course_day': day_name,
      'course_time': time,
      'course_count': count
    };
    DatabaseReference reference = FirebaseDatabase.instance
        .reference().child("users")
        .child(LoginedUser.uid).child("user_courses").child(day_name).push();
    reference.set(user_course);
    return reference.key;
  }
  static Future<Query> queryCourses() async {

    String accountKey = await LoginedUser.uid.toString();
    return FirebaseDatabase.instance
        .reference()
        .child("users")
        .child(accountKey)
        .child("user_courses").child(days[today.weekday%7]).orderByChild("course_time");
  }
  static Future<void> deleteCourses(String name) async{
    FirebaseDatabase.instance.reference().child("users")
        .child(LoginedUser.uid).child("user_courses").child(days[today.weekday%7]).child(name).remove();
  }
}