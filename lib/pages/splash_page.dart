import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gtc_app/models/student.dart';
import 'package:gtc_app/pages/home_page.dart';
import 'package:gtc_app/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 4), (){
      isLogin(context);
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            "assets/logo.jpg",
            height: 150,
          )),
          SizedBox(
            height: 30,
          ),
          Container(width: 200, child: LinearProgressIndicator()),
        ],
      ),
    );
  }

  void isLogin(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("isFirstTime") != null && prefs.getBool("isFirstTime") == true) {
      Student s = Student(
          id: prefs.getInt("UID"),
          name: prefs.getString("UName"),
          image: prefs.getString("UImage"),
          address: prefs.getString("UAddress"),
          phone: prefs.getString("UPhone"));
      openPage(HomePage(student: s), context);
    } else {
      openPage(LoginPage(), context);
    }
  }

  void openPage(Widget page, BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return page;
      },
    ));
  }
}
