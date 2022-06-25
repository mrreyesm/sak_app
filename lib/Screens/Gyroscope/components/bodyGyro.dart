import 'package:flutter/material.dart';
import 'package:sak_app/Screens/Gyroscope/components/backgroundGyro.dart';
import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class SensorData extends StatefulWidget {
  const SensorData({Key? key}) : super(key: key);

  @override
  State<SensorData> createState() => _SensorDataState();
}

class _SensorDataState extends State<SensorData> {
  List<double>? _gyroscopeValues;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  bool isRecording = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final gyroscope =
        _gyroscopeValues?.map((double v) => v.toStringAsFixed(3)).toList();

    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [/*
          SizedBox(height: size.height * 0.03),
          Visibility(
            child: Image.asset("assets/icons/recordbutton.png"),
            visible: isRecording,
            maintainState: true,
            maintainSize: true,
            maintainAnimation: true,
          ),
*/
          Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    "X Axis: ${gyroscope![0]}\nY Axis: ${gyroscope[1]}\nZ Axis: ${gyroscope[2]}",
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
                  // child: BarChart(
                  //   BarChartData(barGroups: [
                  //     BarChartGroupData(
                  //       x: 0,
                  //       barRods: [
                  //         BarChartRodData(
                  //           toY: _gyroscopeValues![0],
                  //           color: Colors.red,
                  //         ),
                  //       ],
                  //     ),
                  //     BarChartGroupData(
                  //       x: 1,
                  //       barRods: [
                  //         BarChartRodData(
                  //           toY: _gyroscopeValues![1],
                  //           color: Colors.green,
                  //         ),
                  //       ],
                  //     ),
                  //     BarChartGroupData(
                  //       x: 2,
                  //       barRods: [
                  //         BarChartRodData(
                  //           toY: _gyroscopeValues![2],
                  //           color: Colors.blue,
                  //         ),
                  //       ],
                  //     ),
                  //   ]),
                  //   swapAnimationDuration: Duration(milliseconds: 150),
                  //   swapAnimationCurve: Curves.linear,
                  // ),
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
                    onTap: () {
                      setState(() {
                        isRecording = true;
                        print("isRecording: $isRecording");
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
                        isRecording = false;
                        print("isRecording: $isRecording");
                      });
                    },
                  ),
                  InkWell(
                    child: Ink(
                      height: size.height * 0.15,
                      width: size.width * (1 / 3),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/icons/stop.png"))),
                    ),
                    onTap: () {
                      setState(() {
                        isRecording = false;
                        print("isRecording: $isRecording");
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
    _gyroscopeValues = [1, 1, 1];
    super.initState();
    _streamSubscriptions.add(
      gyroscopeEvents.listen(
        (GyroscopeEvent event) {
          setState(() {
            _gyroscopeValues = <double>[event.x, event.y, event.z];
          });
        },
      ),
    );
  }
}
