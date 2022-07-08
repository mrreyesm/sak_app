import 'package:flutter/material.dart';
import 'package:sak_app/Screens/Sensor%20Menu/sensorMenu.dart';
import 'package:sak_app/Screens/Under Development/components/backgroundUD.dart';
import 'package:sak_app/Screens/Under Development/underDevelopmentPage.dart';

class BodyUD extends StatelessWidget {
  const BodyUD({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BackgroundUD(
      child: Stack(
        children: [
          InkWell(
            child: Ink(
              decoration: BoxDecoration(
                  color: Colors.grey[600],
                  image: DecorationImage(
                      image:
                          AssetImage("assets/images/underconstruction.jpg"))),
            ),
          ),
          Container(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.grey[700]),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SensorScreen()));
                },
                child: Text("Back"),
              ))
        ],
      ),
    );
  }
}
