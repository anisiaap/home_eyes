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
import 'package:home_eyes/aws/homepage/fav_background.dart';
import 'video_stream.dart';

class HomePage extends StatelessWidget {
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
                    SizedBox(height: 100), // Spacing between text and stream
                    // This is where the video stream is displayed
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Center(
                          //child: VideoStream(),
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
