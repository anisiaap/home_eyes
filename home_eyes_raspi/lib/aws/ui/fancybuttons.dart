import 'dart:io';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:aws_common/vm.dart';
import 'package:flutter/material.dart';
import 'package:home_eyes/aws/faceid/addfaces.dart';
import 'package:home_eyes/aws/homepage/homepage.dart';
import 'package:home_eyes/aws/user/aboutpage.dart';
import 'package:home_eyes/styleguide.dart';
import 'package:path_provider/path_provider.dart';
import 'package:process_run/shell.dart';

// import 'about_page.dart';
// import 'enrolled_page.dart';
// import 'post_page.dart';
// import 'past_page.dart';


class FancyButton extends StatelessWidget {
  final String title;
  final String description;
  final String duration;
  final String page;

  const FancyButton({
    Key? key,
    required this.title,
    required this.description,
    required this.duration,
    required this.page,
  }) : super(key: key);
  Future<void> _writeToFile(String action) async {
    final currentUser = await Amplify.Auth.getCurrentUser();
    final username = switch (currentUser.signInDetails) {
      CognitoSignInDetailsApiBased(:final username) => username,
      _ => currentUser.username,
    };
    String user = username.split('@')[0];
    final key = "$user/doorlock.txt";
    try {
     
      var shell = Shell();

      // Define the two scripts you want to run
      var script1 = '''
        python /home/anisiapirvulescu/Desktop/HomeEyes/home_eyes/lib/hardware/faceid/addLockStatus.py $user $action
      ''';

      // Run both scripts in parallel
      await Future.wait([
         shell.run(script1)
      ]);
    } catch (e) {
      print('Error uploading file: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // Navigate to the specified page based on the 'page' variable
        if (page == "AddFaces") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddFaces()),
          );
        }
        if (page == "AboutPage") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AboutPage()),
          );
        }
        if (page == "PersonListPage") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }
        if (page == "Lock") {
          await _writeToFile('lock');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }
        if (page == "Unlock") {
          await _writeToFile('unlock');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }
        if (page == "ReadCard") {
          await _writeToFile('ReadCard');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 20),
        elevation: 4,
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24))),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                title,
                style: eventTitleTextStyle,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  if (description == "Create new events") Icon(Icons.add),
                  if (description == "View past events") Icon(Icons.arrow_back),
                  if (description == "Events you're attending")
                    Icon(Icons.location_on),
                  if (description == "App description") Icon(Icons.apps),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    description,
                    style: eventDescriptionTextStyle,
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                duration.toUpperCase(),
                textAlign: TextAlign.right,
                style: eventDescriptionTextStyle.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
