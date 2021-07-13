import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gtc_app/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  final _numberController = TextEditingController();
  final _passwordController = TextEditingController();

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
              keyboardType: TextInputType.number,
              obscureText: true,
              controller: _passwordController,
              inputFormatters: [WhitelistingTextInputFormatter(RegExp("[0-9]")),],
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
              child: RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                color: Colors.blue[800],
                child: Text("تسجبل دخول", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return HomePage();
                  },));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
