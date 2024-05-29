import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:process_run/shell.dart';

import 'package:home_eyes/aws/app_state.dart';
import 'package:home_eyes/styleguide.dart';
import 'package:home_eyes/aws/login/loginpage.dart';
import 'package:home_eyes/aws/ui/bottomtab.dart';
import 'package:home_eyes/aws/homepage/fav_background.dart';
import 'video_stream.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    runCamera();
  }

  Future<String?> getCurrentUserPhoneNumber() async {
    try {
      // Fetch the current user's attributes
      List<AuthUserAttribute> userAttributes = await Amplify.Auth.fetchUserAttributes();

      // Find the phone number attribute
      for (var attribute in userAttributes) {
        if (attribute.userAttributeKey == CognitoUserAttributeKey.phoneNumber) {
          return attribute.value;
        }
      }
    } on AuthException catch (e) {
      print('Error fetching user attributes: $e');
    }

    return null;
  }

  Future<void> runCamera() async {
    try {
      final currentUser = await Amplify.Auth.getCurrentUser();
      final username = switch (currentUser.signInDetails) {
        CognitoSignInDetailsApiBased(:final username) => username,
        _ => currentUser.username,
      };
      String user = username.split('@')[0];
      String? phoneNumber = await getCurrentUserPhoneNumber();
      var shell = Shell();

      // Define the two scripts you want to run
      var script1 = '''
        python /home/anisiapirvulescu/Desktop/HomeEyes/home_eyes/lib/hardware/faceid/checkFaceID_persons.py $user $phoneNumber
      ''';

      var script2 = '''
        python /home/anisiapirvulescu/Desktop/HomeEyes/home_eyes/lib/hardware/faceid/streamVideo.py
      ''';

      // Run both scripts in parallel
      await Future.wait([
         shell.run(script1),
         shell.run(script2),

      ]);
      print('execute script');
    } catch (e) {
      print('Error executing script: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<AppState>(
        create: (_) => AppState(),
        child: Stack(
          children: <Widget>[
            const FavePageBackground(),
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32.0),
                          child: Text(
                            'Welcome',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Home Page",
                            style: fadedTextStyle,
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () async {
                              await Amplify.Auth.signOut();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage()),
                                (Route<dynamic> route) => false,
                              );
                            },
                            child: Text("Logout"),
                          ),
                          
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Center(
                        child: VideoStream(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomTabs(UniqueKey(), 0),
    );
  }
}
