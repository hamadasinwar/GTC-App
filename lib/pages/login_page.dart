import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gtc_app/models/student.dart';
import 'package:gtc_app/pages/home_page.dart';
import 'package:gtc_app/utils/constant.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _numberController = TextEditingController();
  final _passwordController = TextEditingController();
  final Student s = Student();
  List<Student> students = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/logo.jpg",height: 150,),
            SizedBox(height: 40.0,),
            TextField(
              keyboardType: TextInputType.number,
              controller: _numberController,
              // ignore: deprecated_member_use
              inputFormatters: [WhitelistingTextInputFormatter(RegExp("[0-9]")),],
              decoration: InputDecoration(
                hintText: "رقم الطالب",
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(30)),
              ),
            ),
            SizedBox(height: 10.0,),
            TextField(
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: "كلمة السر",
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.blue,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(30)),
              ),
            ),
            SizedBox(height: 20.0,),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(40.0)),
              // ignore: deprecated_member_use
              child: RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                color: Colors.blue[800],
                child: Text("تسجبل دخول", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                onPressed: (){
                  var check = false;
                  if(_numberController.text != "" && _passwordController.text != ""){
                    s.id = int.parse(_numberController.text);
                    s.password = _passwordController.text;

                    if(students.isNotEmpty) {
                      for (var student in students) {
                        if (s.id == student.id &&
                            s.password == student.password) {
                          check = true;
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return HomePage(student: student,);
                            },
                          ));
                        }
                      }
                    }else{
                      showSnackBar(context, "ERROR!");
                    }
                  }else{
                    check = true;
                    showSnackBar(context, "الرجاء ملء الحقول");
                  }
                  if(!check){
                    showSnackBar(context, "خطا رقم الطالب او كلمة المرور");
                  }
                },
              ),
            )
          ],
        )
      ),
    );
  }

  Future getData()async{
    var res = await http.get(Uri.parse(Constant().studentsUrl()), headers: {"Accept":"application/json"});
    var response = json.decode(res.body);
    List<Student> st = [];
    for(var d in response){
      var s = Student(id: int.parse(d["id"].toString()), password: d["password"].toString(), name: d["name"].toString(), address: d["address"].toString(), image: d["image"].toString(), phone: d["phone"].toString());
      st.add(s);
    }
    students = st;
  }

  showSnackBar(BuildContext context, String msg){
    final snackBar = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}