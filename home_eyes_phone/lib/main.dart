import 'package:flutter/material.dart';
import 'package:home_eyes/aws/app_state.dart';
import 'package:home_eyes/aws/login/loginpage.dart';
import 'package:home_eyes/amplifyconfiguration.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:provider/provider.dart';
import 'models/ModelProvider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureAmplify();
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MyApp(),
    ),
  );
}

Future<void> configureAmplify() async {
  try {
    final auth = AmplifyAuthCognito();
    final storage = AmplifyStorageS3();
    final dataStore = AmplifyDataStore(modelProvider: ModelProvider.instance);
    final api = AmplifyAPI();
    await Amplify.addPlugins([auth, storage, dataStore, api]);
    await Amplify.configure(amplifyconfig);
  } catch (e) {
    print('Error configuring Amplify: $e');
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
