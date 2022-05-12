import 'package:flutter/material.dart';
import 'package:sak_app/Screens/Welcome/components/background.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "WELCOME TO YOUR SAK",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.05),
            Image.asset(
              "assets/images/main_logo.png",
              height: size.height * 0.4,
              width: size.width * 0.4,
            ),
            SizedBox(height: size.height * 0.05),
            TextButton(
              onPressed: () {}, 
              child: const Text('LOGIN'),
            ),
            TextButton(
              onPressed: () {}, 
              child: const Text('SIGN UP'),
            ),
          ],
        ),
      ),
    );
  }
}
