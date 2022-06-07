import 'package:flutter/material.dart';
import 'package:sak_app/Screens/Accelerometer/components/bodyAccl.dart';

class AcclScreen extends StatelessWidget {
  const AcclScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: AccelerometerData());
  }
}
