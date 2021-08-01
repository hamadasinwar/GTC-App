import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gtc_app/models/grades.dart';
import 'package:gtc_app/utils/constant.dart';
import 'package:http/http.dart' as http;

class GradesPage extends StatelessWidget {
  final int? id;
  var avg = 0.0;
  GradesPage({this.id});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Grades>>(
      future: getGrades(),
      builder: (context, snapshot) {
        List<DataRow> rows = [];
        if(snapshot.hasData) {
          for (var grade in snapshot.data!) {
            if (grade.id == this.id) {
              var _final = grade.finalExam! + grade.mid!;
              var d = DataRow(cells: [
                DataCell(Center(child: Text("${grade.name}"))),
                DataCell(Center(child: Text("${grade.mid}"))),
                DataCell(Center(child: Text("${grade.finalExam}"))),
                DataCell(Center(
                    child: Text("$_final", style: TextStyle(fontWeight: FontWeight.bold,color: _final<60?Colors.red[700]:Colors.black),))),
              ]
              );
              rows.add(d);
            }
          }
        return Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  DataTable(
                      headingRowColor: MaterialStateProperty.all(Colors.blue),
                      showBottomBorder: true,
                      columns: [
                        DataColumn(
                            label: Expanded(child: Center(child: Text("المادة", style: TextStyle(color: Colors.blue[50], fontWeight: FontWeight.bold),)))),
                        DataColumn(
                            label: Expanded(child: Center(child: Text("فصلي", style: TextStyle(color: Colors.blue[50], fontWeight: FontWeight.bold),))),
                            numeric: true),
                        DataColumn(
                            label: Expanded(child: Center(child: Text("نهائي", style: TextStyle(color: Colors.blue[50], fontWeight: FontWeight.bold)))),
                            numeric: true),
                        DataColumn(
                            label: Expanded(child: Center(child: Text("المجموع", style: TextStyle(color: Colors.blue[50], fontWeight: FontWeight.w900)))),
                            numeric: true),
                      ],
                      rows: rows
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("المعدل الفصلي", style: TextStyle(fontSize: 17),),
                        SizedBox(width: 10,),
                        Text("${avg.toStringAsFixed(2)}", style: TextStyle(fontSize: 17, color: Colors.blue, fontWeight: FontWeight.bold),),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        );
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<List<Grades>> getGrades() async {
    double sum = 0.0;
    var res = await http.get(Uri.parse(Constant().gradesUrl()),
        headers: {"Accept": "application/json"});
    var response = json.decode(res.body);
    List<Grades> gd = [];
    for (var d in response) {
      var s = Grades(
        id: int.parse(d["id"].toString()),
        name: d["name"].toString(),
        mid: int.parse(d["mid"].toString()),
        finalExam: int.parse(d["final"].toString()),
      );
      if(s.id == this.id) {
        gd.add(s);
        sum += (s.mid! + s.finalExam!);
      }
    }
    avg = sum / gd.length;
    return gd;
  }
}
