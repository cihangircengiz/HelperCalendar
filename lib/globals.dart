library my_prj.globals;
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

bool isLoggedIn = false;
FirebaseUser LoginedUser;
class Database {
  static Future<String> addCourse(String name,class_name,day_name,time,count) async {
    var user_course = <String, dynamic>{
      'course_name': name,
      'course_class': class_name,
      'course_day': day_name,
      'course_time': time,
      'course_count': count
    };
    DatabaseReference reference = FirebaseDatabase.instance
        .reference().child("users")
        .child(LoginedUser.uid).child("user_courses").push();
    reference.set(user_course);
    return reference.key;
  }
  static Future<Query> queryCourses() async {
    String accountKey = await LoginedUser.uid.toString();
    return FirebaseDatabase.instance
        .reference()
        .child("users")
        .child(accountKey)
        .child("user_courses");
  }
  static Future<void> deleteCourses(String name) async{
    FirebaseDatabase.instance.reference().child("users")
        .child(LoginedUser.uid).child("user_courses").child(name).remove();
  }
}