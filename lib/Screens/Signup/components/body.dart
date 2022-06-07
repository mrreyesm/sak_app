import 'package:flutter/material.dart';
import 'package:sak_app/Screens/Sensor%20Menu/sensorMenu.dart';
import 'package:sak_app/Screens/Signup/components/background.dart';
import 'package:sak_app/constants.dart';
import 'package:sak_app/db/sak_database.dart';
import 'package:sak_app/model/sak.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final idController = TextEditingController();
    final userNameController = TextEditingController();
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final phoneNumberController = TextEditingController();
    final employeeIdController = TextEditingController();
    final passwordController = TextEditingController();
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.15),
            TextField(
              controller: userNameController,
              decoration: InputDecoration(
                hintText: "  Username*",
                hintStyle: TextStyle(color: Colors.black),
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(
                hintText: "  First Name*",
                hintStyle: TextStyle(color: Colors.black),
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(
                hintText: "  Last Name*",
                hintStyle: TextStyle(color: Colors.black),
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            TextField(
              controller: employeeIdController,
              decoration: InputDecoration(
                hintText: "  Employee ID*",
                hintStyle: TextStyle(color: Colors.black),
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                hintText: "  Contact No.*",
                hintStyle: TextStyle(color: Colors.black),
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: "  Password*",
                hintStyle: TextStyle(color: Colors.black),
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            TextField(
              decoration: InputDecoration(
                hintText: "  Confirm Password*",
                hintStyle: TextStyle(color: Colors.black),
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            CheckboxListTile(
              value: true,
              onChanged: (value) {},
              title: Text("Terms and Conditions"),
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: Colors.grey,
            ),
            SizedBox(height: size.height * 0.07),
            Divider(
              thickness: 0.5,
              indent: size.width * 0.05,
              endIndent: size.width * 0.05,
              color: Colors.black,
            ),
            Container(
              child: TextButton(
                child: InkWell(
                  child: Ink(
                    width: 510,
                    height: 70,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/Picture9.png"),
                      ),
                    ),
                    child: Container(
                      height: 510,
                      width: 70,
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
                onPressed: () async {
                  final user = User(
                    userName: userNameController.text,
                    firstName: firstNameController.text,
                    lastName: lastNameController.text,
                    phoneNumber: phoneNumberController.text,
                    employeeId: employeeIdController.text,
                    password: passwordController.text,
                    );
                    
                  await SakDatabase.instance.create(user);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SensorScreen()));
                },
              ),
            ),
            SizedBox(height: size.height * 0.02),
          ],
        ),
      ),
    );
  }
}
