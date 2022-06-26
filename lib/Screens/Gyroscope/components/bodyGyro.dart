import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:sak_app/Screens/Gyroscope/components/backgroundGyro.dart';
import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:time/time.dart';

class SensorData extends StatefulWidget {
  const SensorData({Key? key}) : super(key: key);

  @override
  State<SensorData> createState() => _SensorDataState();
}

class _SensorDataState extends State<SensorData> {
  List<double>? _gyroscopeValues;
  bool _recordingCheck = false;
  DateTime _currentTime = DateTime.now();
  DateTime _utcTime = DateTime.now().subtract(DateTime.now().timeZoneOffset);
  AssetImage _playImage = AssetImage("assets/icons/play.png");
  AssetImage _stopImage = AssetImage("assets/icons/inactivestop.png");
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final gyroscope =
        _gyroscopeValues?.map((double v) => v.toStringAsFixed(3)).toList();

    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    "X Axis: ${gyroscope![0]}\nY Axis: ${gyroscope[1]}\nZ Axis: ${gyroscope[2]}\nRecording: $_recordingCheck\nCurrentTime: $_currentTime\nCurrentTimeUTC: ${_utcTime}Z",
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
                child: Container(
                  height: size.height * 0.4,
                  width: size.width * 0.4,
                  child: Echarts(
                    option: '''
                        {
                          xAxis: {
                          type: 'category',
                          data: ['X', 'Y', 'Z']
                          },
                          yAxis: {
                          type: 'value'
                          },
                          series: [{
                          data: [${gyroscope[0]}, ${gyroscope[1]}, ${gyroscope[2]}],
                          colorBy: 'data',
                          type: 'bar'
                          }]
                        } ''',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.03),
          Row(
            children: [
              Row(
                children: <Widget>[
                  InkWell(
                    child: Ink(
                      height: size.height * 0.15,
                      width: size.width * (1 / 3),
                      decoration: BoxDecoration(
                        image: DecorationImage(image: _playImage),
                      ),
                    ),
                    onTap: () {
                      if (_recordingCheck == true) return;
                      setState(() {
                        _recordingCheck = !_recordingCheck;
                        _playImage =
                            AssetImage("assets/icons/inactiveplay.png");
                        _stopImage = AssetImage("assets/icons/stop.png");
                      });
                    },
                  ),
                  InkWell(
                    child: Ink(
                      height: size.height * 0.15,
                      width: size.width * (1 / 3),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/icons/pause.png"))),
                    ),
                    onTap: () {
                      setState(() {
                        final Capability? pauseCapability;
                      });
                    },
                  ),
                  InkWell(
                    child: Ink(
                      height: size.height * 0.15,
                      width: size.width * (1 / 3),
                      decoration: BoxDecoration(
                          image: DecorationImage(image: _stopImage)),
                    ),
                    onTap: () {
                      setState(() {
                        if (_recordingCheck == false) return;
                        _recordingCheck = !_recordingCheck;
                        _playImage = AssetImage("assets/icons/play.png");
                        _stopImage =
                            AssetImage("assets/icons/inactivestop.png");
                        _recordingStopped();
                      });
                      // AlertDialog(
                      //   title: const Text('Recording Stopped'),
                      //   content: const Text(
                      //       'CSV file will be generated and stored. Start new'),
                      //   actions: <Widget>[
                      //     TextButton(
                      //         onPressed: () {
                      //           Navigator.pop(context, 'OK');
                      //         },
                      //         child: const Text('OK'))
                      //   ],
                      // );
                    },
                  ),
                ],
              ),
            ],
          )
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
    _gyroscopeValues = [1, 1, 1];
    super.initState();
    _streamSubscriptions.add(
      gyroscopeEvents.listen(
        (GyroscopeEvent event) {
          setState(() {
            _currentTime = DateTime.now();
            _utcTime = DateTime.now().subtract(DateTime.now().timeZoneOffset);
            _gyroscopeValues = <double>[event.x, event.y, event.z];
          });
        },
      ),
    );
  }

  Future<void> _recordingStopped() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Recording Stopped'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Recording Stopped'),
                Text('Data stored as a CSV file'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
