import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import 'package:home_eyes/aws/app_state.dart';
import 'package:home_eyes/styleguide.dart';
import 'package:home_eyes/aws/login/uihelper.dart';
import 'package:home_eyes/aws/login/loginpage.dart';
import 'package:home_eyes/aws/ui/bottomtab.dart';
import 'package:home_eyes/aws/ui/fancybuttons.dart';
import 'package:home_eyes/aws/ui/fav_background.dart';
import 'package:home_eyes/aws/user/aboutpage.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userEmail = '';

  @override
  void initState() {
    super.initState();
    _user();
  }

  Future<void> _user() async {
    try {
      final currentUser = await Amplify.Auth.getCurrentUser();
    final username = switch (currentUser.signInDetails) {
      CognitoSignInDetailsApiBased(:final username) => username,
      _ => currentUser.username,
    };
      setState(() {
        userEmail = username.split('@')[0];
      });
    } catch (e) {
      print('Error fetching user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<AppState>(
        create: (_) => AppState(),
        child: Stack(
          children: <Widget>[
            FavePageBackground(
              screenHeight: MediaQuery.of(context).size.height,
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Profile Page",
                            style: fadedTextStyle,
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () async {
                              await Amplify.Auth.signOut();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                                (Route<dynamic> route) =>
                                    false, // Removes all routes from the stack
                              );
                            },
                            child: Text("Logout"),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 20),
                          // Display user's email
                          Text(
                            "Username: $userEmail",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          Column(
                            children: <Widget>[
                              SizedBox(height: 20),
                              FancyButton(
                                  title: "About This App",
                                  description: "",
                                  duration: "Tap for more",
                                  page: "AboutPage"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomTabs(UniqueKey(), 4),
    );
  }
}
