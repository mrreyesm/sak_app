import 'package:flutter/material.dart';
import 'package:sak_app/Screens/Login/login_screen.dart';
import 'package:sak_app/Screens/Signup/signup_screen.dart';
import 'package:sak_app/Screens/Welcome/components/background.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:splashscreen/splashscreen.dart';

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
            SizedBox(height: size.height * 0.05),
            Image.asset(
              "assets/images/main_logo.png",
              height: size.height * 0.4,
              width: size.width * 0.4,
            ),
            const SizedBox(
              height: 30,
              width: 70,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(350, 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24))),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }));
              },
              child: const Text('LOGIN'),
            ),
            TextButton(
              style: TextButton.styleFrom(fixedSize: const Size(350, 40)),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SignUpScreen();
                }));
              },
              child: const Text('SIGN UP'),
            ),
          ],
        ),
      ),
    );
  }
}
