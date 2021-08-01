import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:gtc_app/models/student.dart';
import 'package:gtc_app/pages/grades_page.dart';
import 'package:gtc_app/pages/login_page.dart';
import 'package:gtc_app/pages/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final Student student;

  const HomePage({required this.student});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedIndex = 1;
  List<Widget> pages = [];
  var _controller;

  @override
  void initState() {
    pages = [ProfilePage(student: widget.student,), GradesPage(id: widget.student.id,)];
    _controller = PageController(initialPage: _selectedIndex);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GTC"),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value)async{
              if (value == "تسجيل خروج") {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool("isFirstTime", false);
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
      body: PageView.builder(
        controller: _controller,
        itemCount: pages.length,
        onPageChanged: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        itemBuilder: (context, index) {
          return pages[index];
        },
      ),
      bottomNavigationBar: GNav(
        selectedIndex: _selectedIndex,
        hoverColor: Colors.grey[100]!,
        color: Colors.grey,
        activeColor: Colors.white,
        tabBackgroundColor: Colors.blue,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        tabMargin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
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
            _controller.jumpToPage(value);
          });
        },
      ),
    );
  }
}