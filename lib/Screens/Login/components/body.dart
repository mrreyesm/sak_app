import 'package:flutter/material.dart';
import 'package:sak_app/Screens/Login/components/background.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: ConstrainedBox(
        constraints: const BoxConstraints.tightFor(width: 350),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: "Username",
              ),
            ),
            SizedBox(height: size.height * 0.03),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: "Password",
              ),
            ),
            SizedBox(height: size.height * 0.03),
            ElevatedButton(
              style: ElevatedButton.styleFrom(fixedSize: const Size(350, 40)),
              onPressed: () {},
              child: const Text('LOGIN'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Forgot Password'),
            ),
          ],
        ),
      ),
    );
  }
}
