import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:sak_app/Screens/Login/components/background.dart';
import 'package:sak_app/Screens/Sensor%20Menu/sensorMenu.dart';
import 'package:sak_app/db/sak_database.dart';
import 'package:sak_app/model/sak.dart';
import 'package:intl/intl.dart';
import 'package:csv/csv.dart';
import 'package:external_path/external_path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class SensorsPage extends StatefulWidget {
  @override
  _SensorsPageState createState() => _SensorsPageState();
}

class _SensorsPageState extends State<SensorsPage> {
  late List<Recording> sensors = sensors;
  late List<Sensor> sensorcsv = sensorcsv;
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

    //this.sensors = await SakDatabase.instance.readAllSensors();
    this.sensors = await SakDatabase.instance.readUniqueSensors();

    setState(() => isLoading = false);
  }

  Future _downloadSensor(String name) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Download Sensor Data'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Recording will be downloaded to your device.'),
                //Text('Data stored as a CSV file.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Okay'),
              onPressed: () async {
                setState(() => isLoading = true);
                this.sensorcsv =
                    await SakDatabase.instance.downloadSensor(name);
                //Map<Permission, PermissionStatus> statuses = await [Permission.storage,].request();
                Map<Permission, PermissionStatus> statuses = await [
                  Permission.storage,
                ].request();
                List<dynamic> dynamicValues =
                    List<dynamic>.from(this.sensorcsv);
                List<List<dynamic>> rows = [];

                List<dynamic> row = [];
                row.add("id");
                row.add("sensor");
                row.add("name");
                row.add("xAxis");
                row.add("yAxis");
                row.add("zAxis");
                row.add("time");
                rows.add(row);
                for (int i = 0; i < dynamicValues.length; i++) {
                  List<dynamic> row = [];
                  row.add(dynamicValues[i].id - 1);
                  row.add(dynamicValues[i].sensor);
                  row.add(dynamicValues[i].name);
                  row.add(dynamicValues[i].xAxis);
                  row.add(dynamicValues[i].yAxis);
                  row.add(dynamicValues[i].zAxis);
                  row.add(dynamicValues[i].time);
                  rows.add(row);
                }
                String csv = const ListToCsvConverter().convert(rows);
                String dir =
                    await ExternalPath.getExternalStoragePublicDirectory(
                        ExternalPath.DIRECTORY_DOWNLOADS);
                print("dir $dir");
                String file = "$dir";
                File f = File(
                    file + "/" + name + "_" + dynamicValues[1].sensor + ".csv");
                f.writeAsString(csv);
                setState(() => isLoading = false);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
      //DataColumn(label: Text('Time')),
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
        //DataCell(Text(sensors[i].time)),
        DataCell(Container(
          width: 40,
          child: InkWell(
            child: Ink(
              decoration: BoxDecoration(
                image: DecorationImage(image: _downloadIcon),
              ),
            ),
            onTap: () {
              _downloadSensor(sensors[i].name);
            },
          ),
        ))
      ]);
      rows.add(row);
    }
    return rows;
  }
}
