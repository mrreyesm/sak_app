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

final livenameField = TextEditingController();

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
    final livesensor = "Accelerometer";

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
                          image: DecorationImage(
                              image: AssetImage("assets/icons/play.png"))),
                    ),
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialog(context),
                      );
                      var livename;
                      final sensor = Sensor(
                        sensor: livesensor,
                        name: livename,
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
                          image: DecorationImage(
                              image: AssetImage("assets/icons/stop.png"))),
                    ),
                    onTap: () {},
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

Widget _buildPopupDialog(BuildContext context) {
  return new AlertDialog(
    title: const Text('Start'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            labelText: 'Name Recording',
          ),
          controller: livenameField,
        ),
      ],
    ),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          var livename = livenameField.text;
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Save'),
      ),
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Close'),
      ),
    ],
  );
}
