import 'package:flutter/material.dart';
import 'package:sak_app/Screens/Gyroscope/components/backgroundGyro.dart';
import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:core';

class AccelerometerData extends StatefulWidget {
  const AccelerometerData({Key? key}) : super(key: key);

  @override
  State<AccelerometerData> createState() => _AccelerometerDataState();
}

class _AccelerometerDataState extends State<AccelerometerData> {
  List<double>? _accelerometerValues;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final accelerometer =
        _accelerometerValues?.map((double v) => v.toStringAsFixed(3)).toList();

    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    "X Axis: ${accelerometer![0]}\nY Axis: ${accelerometer[1]}\nZ Axis: ${accelerometer[2]}",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.03),
          Row(
            children: [
              Expanded(
                child: Placeholder(),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.03),
          Row(
            children: [
              Placeholder(
                fallbackWidth: size.width,
                fallbackHeight: size.height * 0.1,
                color: Colors.black,
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    _streamSubscriptions.add(
      accelerometerEvents.listen(
        (AccelerometerEvent event) {
          setState(() {
            _accelerometerValues = <double>[event.x, event.y, event.z];
          });
        },
      ),
    );
  }
}
