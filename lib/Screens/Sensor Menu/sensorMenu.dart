import 'package:flutter/material.dart';
import 'package:sak_app/Screens/Sensor%20Menu/components/body.dart';

class SensorScreen extends StatelessWidget {
  const SensorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
        backgroundColor: Colors.black,
      ),
      drawer: Drawer(),
      body: Body(),
    );
  }
}
