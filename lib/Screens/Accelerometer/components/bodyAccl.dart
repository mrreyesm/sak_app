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

class AccelerometerData extends StatefulWidget {
  const AccelerometerData({Key? key}) : super(key: key);

  @override
  State<AccelerometerData> createState() => _AccelerometerDataState();
}

class _AccelerometerDataState extends State<AccelerometerData> {
  List<double>? _accelerometerValues;
  bool _recordingCheck = false;
  AssetImage _playImage = AssetImage("assets/icons/play.png");
  AssetImage _stopImage = AssetImage("assets/icons/inactivestop.png");
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final accelerometer =
        _accelerometerValues?.map((double v) => v.toStringAsFixed(3)).toList();
    final livesensor = "Accelerometer";
    String valueText = "";
    String codeDialog = "";
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
                      if (_recordingCheck == true) return;
                      setState(() {
                        _recordingCheck = !_recordingCheck;
                        _playImage =
                            AssetImage("assets/icons/inactiveplay.png");
                        _stopImage = AssetImage("assets/icons/stop.png");
                      });
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Enter Live Sensor Name"),
                              content: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    valueText = value;
                                  });
                                },
                                controller: livenameField,
                                decoration: InputDecoration(
                                  labelText: "Live Sensor Name",
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                    child: Text("Save"),
                                    onPressed: () async {
                                      setState(() {
                                        codeDialog = valueText;
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
                      final sensor = Sensor(
                        sensor: livesensor,
                        name: codeDialog,
                        xAxis: accelerometer[0],
                        yAxis: accelerometer[1],
                        zAxis: accelerometer[2],
                        time: DateTime.now(),
                      );
                      await SakDatabase.instance.createSensor(sensor);
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
                        if (_recordingCheck == false) return;
                        _recordingCheck = !_recordingCheck;
                        _playImage = AssetImage("assets/icons/play.png");
                        _stopImage =
                            AssetImage("assets/icons/inactivestop.png");
                      });
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
