import 'package:flutter/material.dart';
import 'package:sak_app/Screens/CSVExport/components/background.dart';

class RecordingList extends StatelessWidget {
  const RecordingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _createDataTable()
      ]
    );
  }
}

DataTable _createDataTable() {
  return DataTable(columns: _createColumns(), rows: _createRows());
}

List<DataColumn> _createColumns() {
  return [
    DataColumn(label: Text('ID')),
    DataColumn(label: Text('Book')),
    DataColumn(label: Text('Author'))
  ];
}

List<DataRow> _createRows() {
  return [
    DataRow(cells: [
      DataCell(Text('#100')),
      DataCell(Text('Flutter Basics')),
      DataCell(Text('David John'))
    ]),
    DataRow(cells: [
      DataCell(Text('#101')),
      DataCell(Text('Dart Internals')),
      DataCell(Text('Alex Wick'))
    ])
  ];
}
