import 'package:flutter/material.dart';
import 'package:sak_app/Screens/Accelerometer/accelerometerPage.dart';
import 'package:sak_app/Screens/Gyroscope/gyroscopePage.dart';
import 'package:sak_app/Screens/Login/login_screen.dart';
import 'package:sak_app/Screens/Sensor%20Menu/components/background.dart';
import 'package:sak_app/Screens/BarcodeScanner/barcodeScannerPage.dart';
import 'package:sak_app/Screens/CSVExport/csvExportPage.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: GridView.count(
        primary: false,
        padding:
            const EdgeInsets.only(top: 150, bottom: 150, left: 50, right: 50),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          Container(
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GyroScreen()));
              },
              child: new GridTile(
                  child: new Image.asset(
                "assets/icons/gyro.png",
                fit: BoxFit.contain,
              )),
            ),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              )
            ], borderRadius: BorderRadius.circular(10), color: Colors.white),
            padding: const EdgeInsets.all(8),
          ),
          Container(
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BarcodeScannerScreen()));
              },
              child: new GridTile(
                  child: new Image.asset(
                "assets/icons/barcode.png",
                fit: BoxFit.contain,
              )),
            ),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              )
            ], borderRadius: BorderRadius.circular(10), color: Colors.white),
            padding: const EdgeInsets.all(8),
          ),
          Container(
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AcclScreen()));
              },
              child: new GridTile(
                  child: new Image.asset(
                "assets/icons/accl.png",
                fit: BoxFit.contain,
              )),
            ),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              )
            ], borderRadius: BorderRadius.circular(10), color: Colors.white),
            padding: const EdgeInsets.all(8),
          ),
          Container(//
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CSVExportScreen()));
              },
              child: new GridTile(
                  child: new Image.asset(
                "assets/icons/export.png",
                fit: BoxFit.contain,
              )),
            ),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              )
            ], borderRadius: BorderRadius.circular(10), color: Colors.white),
            padding: const EdgeInsets.all(8),
          ),
          Container(
            child: InkWell(
              onTap: () {},
              child: new GridTile(
                  child: new Image.asset(
                "assets/icons/mqtt.png",
                fit: BoxFit.contain,
              )),
            ),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              )
            ], borderRadius: BorderRadius.circular(10), color: Colors.white),
            padding: const EdgeInsets.all(8),
          ),
          Container(
            child: InkWell(
              onTap: () {},
              child: new GridTile(
                  child: new Image.asset(
                "assets/icons/sets.png",
                fit: BoxFit.contain,
              )),
            ),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              )
            ], borderRadius: BorderRadius.circular(10), color: Colors.white),
            padding: const EdgeInsets.all(8),
          ),
        ],
      ),
    );
  }
}
