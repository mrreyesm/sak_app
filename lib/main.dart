import 'package:flutter/material.dart';
import 'package:sak_app/Screens/Login/components/body.dart';
import 'constants.dart';
import 'Screens/Welcome/welcome_screen.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SAK App',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Splash2(),
    );
  }
}

// class Splash2 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SplashScreen(
//       seconds: 6,
//       navigateAfterSeconds: new WelcomeScreen(),
//       title: const Text(
//         'DSAK',
//         textScaleFactor: 2,
//       ),
//       image: Image.asset(
//         "assets/images/main_logo.png",
//       ),
//       loadingText: Text("Loading"),
//       photoSize: 100.0,
//       loaderColor: Colors.blue,
//     );
//   }
// }

class Splash2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'DSAK',
        home: AnimatedSplashScreen(
            duration: 10000,
            splash: Image.asset("assets/images/main_logo.png"),
            nextScreen: WelcomeScreen(),
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.fade,
            backgroundColor: Color.fromARGB(255, 125, 184, 232)));
  }
}
