import 'package:flutter/material.dart';
import 'package:sak_app/Screens/Gyroscope/components/backgroundGyro.dart';
import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SensorData extends StatefulWidget {
  const SensorData({Key? key}) : super(key: key);

  @override
  State<SensorData> createState() => _SensorDataState();
}

class _SensorDataState extends State<SensorData> {
  List<double>? _accelerometerValues;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final accelerometer =
        _accelerometerValues?.map((double v) => v.toStringAsFixed(1)).toList();

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
                child: Center(
                  child: Text(
                    "${accelerometer[0]}\n${accelerometer[1]}\n${accelerometer[2]}",
                    style: TextStyle(fontSize: 24.0, color: Colors.black),
                    textAlign: TextAlign.left,
                  ),
                ),
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
  //   return Background(
  // child: Column(
  // children: [
  // Expanded(
  //   child: Center(
  //     child: Text(
  //       "${accelerometer![0]}\n${accelerometer[1]}\n${accelerometer[2]}",
  //       style: TextStyle(fontSize: 24.0, color: Colors.black),
  //       textAlign: TextAlign.center,
  //     ),
  //   ),
  // ),
  //         ElevatedButton(
  //           child: const Text('Back'),
  //           onPressed: () {
  //             Navigator.pop(context);
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
