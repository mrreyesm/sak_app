import 'package:flutter/material.dart';
import 'package:sak_app/Screens/Accelerometer/components/backgroundAccl.dart';
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
                child: Container(
                  height: size.height * 0.4,
                  width: size.width * 0.4,
                  child: BarChart(
                    BarChartData(barGroups: [
                      BarChartGroupData(
                        x: 0,
                        barRods: [
                          BarChartRodData(
                            toY: _accelerometerValues![0],
                            color: Colors.red,
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 1,
                        barRods: [
                          BarChartRodData(
                            toY: _accelerometerValues![1],
                            color: Colors.green,
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 2,
                        barRods: [
                          BarChartRodData(
                            toY: _accelerometerValues![2],
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ]),
                    swapAnimationDuration: Duration(milliseconds: 150),
                    swapAnimationCurve: Curves.linear,
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
                          image: DecorationImage(
                              image: AssetImage("assets/icons/play.png"))),
                    ),
                    onTap: () {},
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
