import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sak_app/Screens/Accelerometer/components/backgroundAccl.dart';
import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:core';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:sak_app/db/sak_database.dart';
import 'package:sak_app/model/sak.dart';
final livesensor = "Accelerometer";
String valueText = "";
String codeDialog = "";

class AccelerometerData extends StatefulWidget {
  const AccelerometerData({Key? key}) : super(key: key);

  @override
  State<AccelerometerData> createState() => _AccelerometerDataState();
}

class _AccelerometerDataState extends State<AccelerometerData> {
  List<double>? _accelerometerValues;
  late List _acclDBArray;
  bool _recordingCheck = false;
  AssetImage _playImage = AssetImage("assets/icons/play.png");
  AssetImage _stopImage = AssetImage("assets/icons/inactivestop.png");
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  DateTime _currentTime = DateTime.now();
  DateTime _utcTime = DateTime.now().subtract(DateTime.now().timeZoneOffset);
  late List<String> _timeUTCList, _timeLocalList;
  var _sendToDBList = <dynamic>[];
  late var listLength;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final accelerometer =
    _accelerometerValues?.map((double v) => v.toStringAsFixed(3)).toList();
    _timeLocalList = [DateTime.now().toString()];
    _timeUTCList = [
      DateTime.now().subtract(DateTime.now().timeZoneOffset).toString()
    ];
    _acclDBArray = [
      accelerometer![0],
      accelerometer[1],
      accelerometer[2],
      //_timeLocalList,
      _timeUTCList
    ];
    listLength = _sendToDBList.length;

    TextEditingController livenameField = TextEditingController();
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            livesensor,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    "X Axis: ${accelerometer[0]}\nY Axis: ${accelerometer[1]}\nZ Axis: ${accelerometer[2]}\nCurrentTime: $_currentTime\nList: $listLength",
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
              Container(
                height: size.height * 0.4,
                width: size.width,
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
                          data: [${accelerometer[0]}, ${accelerometer[1]}, ${accelerometer[2]}],
                          colorBy: 'data',
                          type: 'bar'
                          }]
                        } ''',
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
                          image: DecorationImage(image: _playImage)),
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
                                  labelText: "Recoding Name",
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
                                        _playImage = AssetImage("assets/icons/inactiveplay.png");
                                        _stopImage = AssetImage("assets/icons/stop.png");
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
                        var sensor = Sensor(
                          sensor: livesensor,
                          name: codeDialog,
                          xAxis: accelerometer[0],
                          yAxis: accelerometer[1],
                          zAxis: accelerometer[2],
                          time: DateTime.now(),
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
                    },
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
                Text('Data stored as a CSV file.'),
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
                onPressed: () async {
                  Navigator.of(context).pop();
                  setState(() {
                    if (_recordingCheck == false) return;
                    _recordingCheck = !_recordingCheck;
                    _playImage = AssetImage("assets/icons/play.png");
                    _stopImage = AssetImage("assets/icons/inactivestop.png");
                  });
                  _recordingStopped();
                  //await SakDatabase.instance.createSensors(_sendToDBList, codeDialog, livesensor);
                },
                child: const Text('Yes'))
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _streamSubscriptions.add(
      accelerometerEvents.listen(
        (AccelerometerEvent event) {
          setState(() {
            _accelerometerValues = <double>[event.x, event.y, event.z];
            _currentTime = DateTime.now();
            _utcTime = DateTime.now().subtract(DateTime.now().timeZoneOffset);
            if (_recordingCheck == false) return;
            _timeLocalList = _timeLocalList;
            _timeUTCList = _timeUTCList;
            _acclDBArray = _acclDBArray;
            _sendToDBList = _sendToDBList + _acclDBArray;
            listLength = _sendToDBList.length;
          });
        },
      ),
    );
  }
}
