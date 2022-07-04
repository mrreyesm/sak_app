import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:sak_app/Screens/Login/components/background.dart';
import 'package:sak_app/Screens/Sensor%20Menu/sensorMenu.dart';
import 'package:sak_app/db/sak_database.dart';
import 'package:sak_app/model/sak.dart';
import 'package:intl/intl.dart';

class SensorsPage extends StatefulWidget {
  @override
  _SensorsPageState createState() => _SensorsPageState();
}

class _SensorsPageState extends State<SensorsPage> {
  late List<Sensor> sensors = sensors;
  bool isLoading = false;
  AssetImage _downloadIcon = AssetImage("assets/icons/dlicon.png");

  @override
  void initState() {
    super.initState();

    refreshSensors();
  }

  @override
  void dispose() {
    SakDatabase.instance.close();

    super.dispose();
  }

  Future refreshSensors() async {
    setState(() => isLoading = true);

    this.sensors = await SakDatabase.instance.readAllSensors();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView(children: [_createDataTable()]);
  }

  DataTable _createDataTable() {
    return DataTable(
        dividerThickness: 2,
        columnSpacing: 0,
        columns: _createColumns(),
        rows: _createRows());
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('Name')),
      DataColumn(label: Text('Sensor')),
      DataColumn(label: Text('Time')),
      DataColumn(label: Text('Download')),
    ];
  }

  List<DataRow> _createRows() {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");
    List<DataRow> rows = [];
    for (int i = 0; i < sensors.length; i++) {
      final row = DataRow(cells: [
        DataCell(
          Container(width: 75, child: Text(sensors[i].name)),
        ),
        DataCell(Text(sensors[i].sensor)),
        DataCell(Text(dateFormat.format(sensors[i].time))),
        DataCell(Container(
          width: 40,
          child: InkWell(
            child: Ink(
              decoration: BoxDecoration(
                image: DecorationImage(image: _downloadIcon),
              ),
            ),
            onTap: () {},
          ),
        ))
      ]);
      rows.add(row);
    }
    return rows;
  }
}