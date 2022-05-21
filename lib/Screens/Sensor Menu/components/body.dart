import 'package:flutter/material.dart';
import 'package:sak_app/Screens/Sensor%20Menu/components/background.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding:
          const EdgeInsets.only(top: 150, bottom: 150, left: 50, right: 50),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        Container(
          child: InkWell(
            onTap: () {},
            child: new GridTile(
                child: new Image.asset(
              "assets/icons/gyro.png",
              fit: BoxFit.cover,
            )),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.teal[50]),
          padding: const EdgeInsets.all(8),
        ),
        Container(
          child: InkWell(
            onTap: () {},
            child: new GridTile(
                child: new Image.asset(
              "assets/icons/barcode.png",
              fit: BoxFit.cover,
            )),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.teal[50]),
          padding: const EdgeInsets.all(8),
        ),
        Container(
          child: InkWell(
            onTap: () {},
            child: new GridTile(
                child: new Image.asset(
              "assets/icons/accl.png",
              fit: BoxFit.cover,
            )),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.teal[50]),
          padding: const EdgeInsets.all(8),
        ),
        Container(
          child: InkWell(
            onTap: () {},
            child: new GridTile(
                child: new Image.asset(
              "assets/icons/export.png",
              fit: BoxFit.cover,
            )),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.teal[50]),
          padding: const EdgeInsets.all(8),
        ),
        Container(
          child: InkWell(
            onTap: () {},
            child: new GridTile(
                child: new Image.asset(
              "assets/icons/mqtt.png",
              fit: BoxFit.cover,
            )),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.teal[50]),
          padding: const EdgeInsets.all(8),
        ),
        Container(
          child: InkWell(
            onTap: () {},
            child: new GridTile(
                child: new Image.asset(
              "assets/icons/sets.png",
              fit: BoxFit.cover,
            )),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.teal[50]),
          padding: const EdgeInsets.all(8),
        ),
      ],
    );
  }
}
