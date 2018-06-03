import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';
import 'globals.dart' as globals;
class LoginPage extends StatefulWidget{
  static String tag = "login-page";
  @override
  State createState() => LoginPageState();
}
class LoginPageState extends State<LoginPage>{
  @override
  static final TextEditingController _email = new TextEditingController();
  static final TextEditingController _pass = new TextEditingController();
  /*String get email => _email.text;
  String get pass => _pass.text;
*/
  String get email => "nowdyle@gmail.com";
  String get pass => "123456";

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> _signIn() async{
    FirebaseUser user = await _auth.signInWithEmailAndPassword(email: email, password: pass);
    globals.LoginedUser= user;
    return user;
  }
  Widget build(BuildContext context){
    return new Scaffold(
      backgroundColor: Colors.greenAccent,
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Image(image: new AssetImage("assets/bg.jpg"),
            fit:BoxFit.cover,
            color:Colors.black54,
            colorBlendMode: BlendMode.darken,
          ),
          new Form(
            child: new Theme(
              data: new ThemeData(
                  brightness: Brightness.dark,
                  primarySwatch: Colors.teal,
                  inputDecorationTheme: new InputDecorationTheme(
                      labelStyle: new TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 30.0
                      )
                  )),
              child: new Container(
                padding: const EdgeInsets.all(40.0),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new TextFormField(
                      decoration: new InputDecoration(
                        labelText: "Enter Email",

                      ),
                      keyboardType: TextInputType.emailAddress,
                      controller: _email,
                    ),
                    new TextFormField(
                      decoration: new InputDecoration(
                        labelText: "Enter Password",
                      ),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      controller: _pass,
                    ),

                    new Padding(padding: const EdgeInsets.only(top:40.0)),
                    new MaterialButton(
                      height: 40.0,
                      onPressed: () =>  _signIn().then((FirebaseUser user)=>Navigator.of(context).pushNamed(HomePage.tag)).catchError((e)=>print("Faild")),
                      color: Colors.teal,
                      textColor: Colors.white,
                      child: new Text("Login"),
                      splashColor: Colors.redAccent,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}