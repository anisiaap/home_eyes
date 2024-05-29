import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:provider/provider.dart';

import 'package:home_eyes/aws/login/uihelper.dart';
import 'package:home_eyes/aws/homepage/homepage.dart';
import 'package:home_eyes/aws/login/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();

  login(String email, String password) async {
    try {
      await Amplify.Auth.signOut();
    } on AuthException catch (e) {}
    if (email == "" && password == "") {
      return UiHelper.CustomAlertBox(context, "Enter Required Fields");
    } else {
      try {
        SignInResult res = await Amplify.Auth.signIn(
          username: email,
          password: password,
        );
        return Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } catch (e) {
        UiHelper.CustomAlertBox(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/house.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UiHelper.CustomTextField(
              emailControler,
              "Email",
              Icons.mail,
              false,
              placeholder: "Enter your email",
              placeholderColor: Colors.grey,
            ),
            UiHelper.CustomTextField(
              passwordControler,
              "Password",
              Icons.password,
              true,
              placeholder: "Enter your password",
              placeholderColor: Colors.grey,
            ),
            SizedBox(height: 20),
            UiHelper.CustomButton(
              () {
                login(
                  emailControler.text.toString(),
                  passwordControler.text.toString(),
                );
              },
              "Login",
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an Account?",
                  style: TextStyle(fontSize: 16),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpPage(),
                      ),
                    );
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: themeData.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
