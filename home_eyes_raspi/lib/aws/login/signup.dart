import 'package:flutter/material.dart';
import 'dart:io';
import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:home_eyes/aws/login/uihelper.dart';
import 'package:home_eyes/aws/homepage/homepage.dart';
import 'package:process_run/shell.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();
  TextEditingController addressControler = TextEditingController();
  TextEditingController phoneControler = TextEditingController();
  TextEditingController nameControler = TextEditingController();

  Future<void> runPythonScript(String collectionId) async { 
    try {
      var shell = Shell();

      // Define the two scripts you want to run
      var script1 = '''
        python /home/anisiapirvulescu/Desktop/HomeEyes/home_eyes/lib/hardware/faceid/newUserCollection.py $collectionId
      ''';
      // Run both scripts in parallel
      await Future.wait([
         shell.run(script1),

      ]);
    } catch (e) {
      print('Error executing Python script: $e');
    }
  }
  signUp(String email, String password, String address, String name,
      String phone) async {
    if (email == "" ||
        password == "" ||
        address == "" ||
        name == "" ||
        phone == "") {
      UiHelper.CustomAlertBox(context, "Enter Required Fields");
      return;
    }
    try {
      await Amplify.Auth.signOut();
    } on AuthException catch (e) {}
    if (email == "" && password == "") {
      return UiHelper.CustomAlertBox(context, "Enter Required Fields");
    } else {
        try {
          final userAttributes = {
            AuthUserAttributeKey.phoneNumber: phone,
            AuthUserAttributeKey.address: address,
            AuthUserAttributeKey.name: name
          };
          final result = await Amplify.Auth.signUp(
            username: email,
            password: password,
            options: SignUpOptions(
              userAttributes: userAttributes,
            ),
          );

          String nameCol = email.split('@')[0];
          runPythonScript(nameCol);

          return Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } catch (e) {
          // Handle sign-up error
          UiHelper.CustomAlertBox(context, e.toString());
        }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up on HomeEyes"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.CustomTextField(emailControler, "Email", Icons.mail, false),
          UiHelper.CustomTextField(
              passwordControler, "Password", Icons.password, true),
          UiHelper.CustomTextField(
              addressControler, "Address", Icons.mail, false),
          UiHelper.CustomTextField(nameControler, "Name", Icons.mail, false),
          UiHelper.CustomTextField(phoneControler, "Phone", Icons.mail, false),
          SizedBox(height: 30),
          UiHelper.CustomButton(() {
            signUp(
                emailControler.text.toString(),
                passwordControler.text.toString(),
                addressControler.text.toString(),
                nameControler.text.toString(),
                phoneControler.text.toString());
          }, "SignUp"),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
