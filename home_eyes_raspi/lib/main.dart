import 'dart:io';

import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import 'package:home_eyes/aws/login/loginpage.dart';
import 'package:home_eyes/amplifyconfiguration.dart';
import 'package:window_size/window_size.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureAmplify();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('HomeEyes');
    setWindowMaxSize(const Size(800, 480));
    setWindowMinSize(const Size(800, 480));
  }
  runApp(MyApp());

}

Future<void> configureAmplify() async {
  try {
    final auth = AmplifyAuthCognito();
    final storage = AmplifyStorageS3();
    await Amplify.addPlugins([auth]);
    await Amplify.configure(amplifyconfig);
  } catch (e) {
      safePrint('An error occurred configuring Amplify: $e');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFFFFFFF),
        primaryColor: Color.fromARGB(255, 233, 163, 184),
      ),
      home: LoginPage(),
    );
  }
}
