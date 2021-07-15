import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:gtc_app/models/student.dart';
import 'package:gtc_app/pages/grades_page.dart';
import 'package:gtc_app/pages/login_page.dart';
import 'package:gtc_app/pages/profile_page.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedIndex = 1;
  List<Widget> pages = [ ProfilePage(), GradesPage()];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GTC"),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == "تسجيل خروج") {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return LoginPage();
                  },
                ));
              }
            },
            itemBuilder: (BuildContext context) {
              return {'تسجيل خروج'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: ListTile(
                    title: Text(choice),
                    trailing: Icon(
                      Icons.logout,
                      color: Colors.red[800],
                    ),
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Student>>(
        future: getData(),
        builder: (context, snapshot) {
          print(snapshot.data?[0]);
          return pages[_selectedIndex];
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            selectedIndex: _selectedIndex,
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            color: Colors.grey,
            activeColor: Colors.blue[800],
            tabBackgroundColor: Colors.blue.withOpacity(0.1),
            tabs: [
              GButton(
                icon: Icons.person_rounded,
                text: 'الملف الشخصي',
              ),
              GButton(
                icon: Icons.grade_rounded,
                text: 'الدرجات',
              ),
            ],
            onTabChange: (value) {
              setState(() {
                _selectedIndex = value;
              });
            },
          ),
        ),
      ),
    );
  }

  Future<List<Student>> getData() async {
    var url = "http://10.0.3.151/GTC/getStudents.php";
    var res =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    var response = json.decode(res.body);
    List<Student> st = [];
    for (var d in response) {
      var s = Student(
          id: int.parse(d["id"].toString()),
          password: d["password"].toString());
      st.add(s);
    }
    return st;
  }
}
