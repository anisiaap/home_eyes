import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';

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
  bool showKeyboard = false;
  TextEditingController? activeController;

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

  void toggleKeyboard(TextEditingController controller) {
    setState(() {
      showKeyboard = !showKeyboard;
      activeController = controller;
    });
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
              onTap: () => toggleKeyboard(emailControler),
            ),
            UiHelper.CustomTextField(
              passwordControler,
              "Password",
              Icons.password,
              true,
              placeholder: "Enter your password",
              placeholderColor: Colors.grey,
              onTap: () => toggleKeyboard(passwordControler),
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
            if (showKeyboard)
              Container(
                height: 300,
                color: Colors.grey[200],
                child: VirtualKeyboard(
                  height: 300,
                  textColor: Colors.black,
                  type: VirtualKeyboardType.Alphanumeric,
                  onKeyPress: (key) {
                    if (activeController != null) {
                      if (key.text == null) {
                        // Handle special keys
                        if (key.action == VirtualKeyboardKeyAction.Backspace) {
                          if (activeController!.text.isNotEmpty) {
                            activeController!.text = activeController!.text
                                .substring(
                                    0, activeController!.text.length - 1);
                          }
                        } else if (key.action ==
                            VirtualKeyboardKeyAction.Return) {
                          activeController!.text += '\n';
                        } else if (key.action ==
                            VirtualKeyboardKeyAction.Space) {
                          activeController!.text += ' ';
                        }
                      } else {
                        // Insert the character key
                        activeController!.text += key.text!;
                      }
                      // Move cursor to the end of the text
                      activeController!.selection = TextSelection.fromPosition(
                        TextPosition(offset: activeController!.text.length),
                      );
                    }
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
