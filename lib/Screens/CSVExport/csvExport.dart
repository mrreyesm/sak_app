import 'package:flutter/material.dart';
import 'package:sak_app/Screens/CSVExport/components/body.dart';
import 'package:sak_app/Screens/Login/login_screen.dart';
import 'package:sak_app/Screens/Sensor%20Menu/sensorMenu.dart';

class CSVExportScreen extends StatelessWidget {
  const CSVExportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
        backgroundColor: Colors.indigo[900],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text("Menu"),
              decoration: BoxDecoration(
                color: Colors.teal[100],
              ),
            ),
            ListTile(
              title: Text("Sensor Menu"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SensorScreen()));
              },
            ),
            ListTile(
              title: Text("Logout"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              },
            ),
          ],
        ),
      ),
      body: RecordingList(),
    );
  }
}