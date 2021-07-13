import 'package:flutter/material.dart';
import 'package:gtc_app/pages/login_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GTC"),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if(value == "تسجيل خروج"){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return LoginPage();
                },));
              }
            },
            itemBuilder: (BuildContext context) {
              return {'تسجيل خروج'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: ListTile(
                    title: Text(choice),
                    trailing: Icon(Icons.logout, color: Colors.red[800],),
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Container(
        child: SizedBox.expand(
          child: DataTable(
            showBottomBorder: true,
            columns: [
              DataColumn(label: Expanded(child: Center(child: Text("المادة")))),
              DataColumn(label: Expanded(child: Center(child: Text("الدرجة"))), numeric: true),
            ],
            rows: [
              DataRow(
                  cells: [
                    DataCell(Center(child: Text("IOS"))),
                    DataCell(Center(child: Text("99"))),
                    ]
              )
            ],
          ),
        ),
      ),
    );
  }
}