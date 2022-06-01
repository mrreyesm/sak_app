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
            Container(
              child: TextButton(
                child: InkWell(
                  child: Ink(
                    width: 250,
                    height: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/Picture9.png"),
                      ),
                    ),
                    child: Container(
                      height: 250,
                      width: 120,
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
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
              ),
            ),
            Container(
              child: TextButton(
                child: InkWell(
                  child: Ink(
                    width: 250,
                    height: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/Picture9.png"),
                      ),
                    ),
                    child: Container(
                      height: 250,
                      width: 50,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "SIGN UP",
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
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpScreen()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
