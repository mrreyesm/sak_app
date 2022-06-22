import 'dart:ui';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:sak_app/Screens/Login/components/background.dart';
import 'package:sak_app/Screens/Sensor%20Menu/sensorMenu.dart';
import 'package:sak_app/db/sak_database.dart';
import 'package:sak_app/model/sak.dart';

class SensorCardWidget extends StatelessWidget {
  SensorCardWidget({
    Key? key,
    required this.sensor,
    required this.index,
  }) : super(key: key);

  final Sensor sensor;
  final int index;

  @override
  Widget build(BuildContext context) {
    /// Pick colors from the accent colors based on index
    final minHeight = getMinHeight(index);

    return Card(
      child: Container(
        constraints: BoxConstraints(minHeight: minHeight),
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(
              sensor.name,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              sensor.sensor,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              sensor.xAxis,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              sensor.yAxis,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              sensor.zAxis,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              sensor.time.toIso8601String(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// To return different height for different widgets
  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 150;
      case 3:
        return 100;
      default:
        return 100;
    }
  }
}



class SensorsPage extends StatefulWidget {
  @override
  _SensorsPageState createState() => _SensorsPageState();
}


class _SensorsPageState extends State<SensorsPage> {
  late List<Sensor> sensors;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshSensors();
  }

  @override
  void dispose() {
    SakDatabase.instance.close();

    super.dispose();
  }

  Future refreshSensors() async {
    setState(() => isLoading = true);

    this.sensors = await SakDatabase.instance.readAllSensors();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : sensors.isEmpty
                  ? Text(
                      'No Sensors',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  : buildSensors(),
        ),
      );

  Widget buildSensors() => StaggeredGridView.countBuilder(
      padding: EdgeInsets.all(8),
      itemCount: sensors.length,
      staggeredTileBuilder: (index) => StaggeredTile.fit(2),
      crossAxisCount: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemBuilder: (context, index) {
      final sensor = sensors[index];
      return SensorCardWidget(sensor: sensor, index: index);
      },
    );  
}

