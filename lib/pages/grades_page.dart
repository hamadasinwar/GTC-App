import 'package:flutter/material.dart';

class GradesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox.expand(
        child: DataTable(
          showBottomBorder: true,
          columns: [
            DataColumn(
                label: Expanded(child: Center(child: Text("المادة")))),
            DataColumn(
                label: Expanded(child: Center(child: Text("الدرجة"))),
                numeric: true),
          ],
          rows: [
            DataRow(cells: [
              DataCell(Center(child: Text("IOS"))),
              DataCell(Center(child: Text("99"))),
            ])
          ],
        ),
      ),
    );
  }
}
