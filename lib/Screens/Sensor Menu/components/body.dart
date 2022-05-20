import 'package:flutter/material.dart';
import 'package:sak_app/Screens/Sensor%20Menu/components/background.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.teal[50]),
          padding: const EdgeInsets.all(8),
          // color: Colors.teal[100],
          child: const Text("Placeholder 1"),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.teal[50]),
          padding: const EdgeInsets.all(8),
          // color: Colors.teal[200],
          child: const Text("Placeholder 2"),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.teal[50]),
          padding: const EdgeInsets.all(8),
          // color: Colors.teal[300],
          child: const Text("Placeholder 3"),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.teal[50]),
          padding: const EdgeInsets.all(8),
          // color: Colors.teal[400],
          child: const Text("Placeholder 4"),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.teal[50]),
          padding: const EdgeInsets.all(8),
          // color: Colors.teal[500],
          child: const Text("Placeholder 5"),
        ),
        Container(
          child: InkWell(
            onTap: () {},
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.teal[50]),
          padding: const EdgeInsets.all(8),
          // color: Colors.teal[600],
          // child: const Text("Placeholder 6"),
        ),
      ],
    );
  }
}
