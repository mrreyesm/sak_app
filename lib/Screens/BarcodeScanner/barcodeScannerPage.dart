import 'package:flutter/material.dart';
import 'package:sak_app/Screens/BarcodeScanner/components/body.dart';

class BarcodeScannerScreen extends StatelessWidget {
  const BarcodeScannerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UsersPage(),
    );
  }
}
