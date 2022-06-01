import 'package:flutter/material.dart';
import 'package:sak_app/Screens/Gyroscope/components/backgroundGyro.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Placeholder(
                fallbackWidth: size.width,
                fallbackHeight: size.height * 0.1,
                color: Colors.black,
              )
            ],
          ),
          SizedBox(height: size.height * 0.03),
          Row(
            children: [
              Placeholder(
                fallbackWidth: size.width,
                fallbackHeight: size.height * 0.3,
                color: Colors.black,
              )
            ],
          ),
          SizedBox(height: size.height * 0.03),
          Row(
            children: [
              Placeholder(
                fallbackWidth: size.width,
                fallbackHeight: size.height * 0.1,
                color: Colors.black,
              )
            ],
          ),
        ],
      ),
    );
  }
}
