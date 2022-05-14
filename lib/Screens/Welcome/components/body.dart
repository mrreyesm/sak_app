import 'package:flutter/material.dart';
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
            AnimatedTextKit(
              animatedTexts: [
                ScaleAnimatedText(
                  'WELCOME',
                  textStyle: const TextStyle(
                      fontFamily: 'Canterbury',
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(239, 222, 125, 20)),
                ),
                ScaleAnimatedText(
                  'TO YOUR',
                  textStyle: const TextStyle(
                      fontFamily: 'Canterbury',
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(239, 222, 125, 20)),
                ),
                ScaleAnimatedText(
                  'SAK APP!',
                  textStyle: const TextStyle(
                      fontFamily: 'Canterbury',
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(239, 222, 125, 20)),
                ),
              ],
              totalRepeatCount: 1,
              pause: const Duration(milliseconds: 500),
              displayFullTextOnTap: true,
              stopPauseOnTap: true,
            ),
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
