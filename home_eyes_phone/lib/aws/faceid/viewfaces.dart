import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:home_eyes/models/FacePhotos.dart';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

class PersonListPage extends StatefulWidget {
  @override
  _PersonListPageState createState() => _PersonListPageState();
}

class _PersonListPageState extends State<PersonListPage> {
  List<FacePhotos> _persons = [];

  @override
  void initState() {
    super.initState();
    fetchPersons();
  }

  Future<void> fetchPersons() async {
    try {
      final currentUser = await Amplify.Auth.getCurrentUser();
      final username = switch (currentUser.signInDetails) {
        CognitoSignInDetailsApiBased(:final username) => username,
        _ => currentUser.username,
      };

      // Construct a filter expression to match the current user's username
      final filter = FacePhotos.USER.eq(username);

      // Query persons with the constructed filter expression
      List<FacePhotos> persons = await Amplify.DataStore.query(
        FacePhotos.classType,
        where: filter,
      );

      setState(() {
        _persons = persons;
      });
    } catch (e) {
      print('Error fetching persons: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Person List'),
      ),
      body: ListView.builder(
        itemCount: _persons.length,
        itemBuilder: (context, index) {
          final person = _persons[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: Image.network(
                      person.photo,
                      height: 150,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                person.name,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
