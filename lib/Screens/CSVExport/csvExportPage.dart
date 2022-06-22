import 'package:flutter/material.dart';
import 'package:sak_app/Screens/CSVExport/components/body.dart';

class CSVExportScreen extends StatelessWidget {
  const CSVExportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SensorsPage(),
    );
  }
}
