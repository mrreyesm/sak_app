import 'dart:isolate';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sak_app/Screens/Gyroscope/components/backgroundGyro.dart';
import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:time/time.dart';
import 'package:sak_app/db/sak_database.dart';
import 'package:sak_app/model/sak.dart';

final livesensor = "Gyroscope";
String valueText = "";
String codeDialog = "";

class SensorData extends StatefulWidget {
  const SensorData({Key? key}) : super(key: key);

  @override
  State<SensorData> createState() => _SensorDataState();
}

class _SensorDataState extends State<SensorData> {
  List<double>? _gyroscopeValues;
  late List _gyroDBArray;
  bool _recordingCheck = false;
  DateTime _currentTime = DateTime.now();
  DateTime _utcTime = DateTime.now().subtract(DateTime.now().timeZoneOffset);
  AssetImage _playImage = AssetImage("assets/icons/play.png");
  AssetImage _stopImage = AssetImage("assets/icons/inactivestop.png");
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  late List<String> _timeUTCList, _timeLocalList;
  var _sendToDBList = <dynamic>[];
  late var listLength;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final gyroscope =
        _gyroscopeValues?.map((double v) => v.toStringAsFixed(3)).toList();
    _timeLocalList = [DateTime.now().toString()];
    _timeUTCList = [
      DateTime.now().subtract(DateTime.now().timeZoneOffset).toString()
    ];
    _gyroDBArray = [
      gyroscope![0],
      gyroscope[1],
      gyroscope[2],
      _timeUTCList
    ];
    listLength = _sendToDBList.length;

    TextEditingController livenameField = TextEditingController();
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    "X Axis: ${gyroscope[0]}\nY Axis: ${gyroscope[1]}\nZ Axis: ${gyroscope[2]}\nCurrentTime: $_currentTime\nCurrentTimeUTC: ${_utcTime}Z\nLength: $listLength",
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
                    onTap: () async {
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Enter Recording Name"),
                              content: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    valueText = value;
                                  });
                                },
                                controller: livenameField,
                                decoration: InputDecoration(
                                  labelText: "Recording Name",
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                    child: Text("Save"),
                                    onPressed: () async {
                                      if (_recordingCheck == true) return;
                                      setState(() {
                                        codeDialog = valueText;
                                        _recordingCheck = !_recordingCheck;
                                        _playImage = AssetImage(
                                            "assets/icons/inactiveplay.png");
                                        _stopImage =
                                            AssetImage("assets/icons/stop.png");
                                        Navigator.pop(context);
                                      });
                                    }),
                                TextButton(
                                  child: Text("Cancel"),
                                  onPressed: () {
                                    setState(() {
                                      Navigator.pop(context);
                                    });
                                  },
                                ),
                              ],
                            );
                          });
                      while (_recordingCheck == true) {
                        await Future.delayed(Duration(milliseconds: 500));
                        final sensor = Sensor(
                          sensor: livesensor,
                          name: codeDialog,
                          xAxis: _gyroDBArray[0],
                          yAxis: _gyroDBArray[1],
                          zAxis: _gyroDBArray[2],
                          time: _utcTime,
                        );
                        await SakDatabase.instance.createSensor(sensor);
                      }
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
                    onTap: () {},
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
                      _confirmStopDialogue();
                      });
                    }
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width * (1 / 3),
              ),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.2,
                height: size.height * 0.1,
                child: Visibility(
                  child: Image.asset("assets/icons/recordbutton.png"),
                  visible: _recordingCheck,
                  maintainState: true,
                  maintainSize: true,
                  maintainAnimation: true,
                ),
              ),
              SizedBox(
                width: size.width * (1 / 3),
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
            if (_recordingCheck == false) return;
            _timeLocalList = _timeLocalList;
            _timeUTCList = _timeUTCList;
            _gyroDBArray = _gyroDBArray;
            _sendToDBList = _sendToDBList + _gyroDBArray;
            listLength = _sendToDBList.length;
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
                Text('Recording Stopped.'),
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

  Future<void> _confirmStopDialogue() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Recording Stop'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Do you want to end the recording?'),
                Text('Data recording will be stopped'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
                _recordingCheck == false;
              },
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    if (_recordingCheck == false) return;
                    _recordingCheck = !_recordingCheck;
                    _playImage = AssetImage("assets/icons/play.png");
                    _stopImage = AssetImage("assets/icons/inactivestop.png");
                  });
                  _recordingStopped();
                },
                child: const Text('Yes'))
          ],
        );
      },
    );
  }
}
