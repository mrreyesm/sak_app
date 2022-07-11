import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sak_app/Screens/Login/components/background.dart';
import 'package:sak_app/Screens/Sensor%20Menu/sensorMenu.dart';
import 'package:permission_handler/permission_handler.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: ConstrainedBox(
        constraints: const BoxConstraints.tightFor(width: 350),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: "Username or Email",
              ),
            ),
            SizedBox(height: size.height * 0.03),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: "Password",
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              child: TextButton(
                child: InkWell(
                  child: Ink(
                    width: 510,
                    height: 70,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/Picture9.png"),
                      ),
                    ),
                    child: Container(
                      height: 510,
                      width: 70,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'varelaround'),
                        ),
                      ),
                    ),
                  ),
                ),
                onPressed: () async {
                  Map<Permission, PermissionStatus> statuses = await [
                    Permission.storage,
                  ].request();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SensorScreen()));
                },
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SensorScreen()));
              },
              child: const Text(
                'FORGOT PASSWORD?',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'varelaround',
                    fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
