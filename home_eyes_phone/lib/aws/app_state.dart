import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:amazon_cognito_identity_dart_2/sig_v4.dart';
import 'package:aws_dynamodb_api/dynamodb-2012-08-10.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:home_eyes/models/ModelProvider.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; // Add this for date formatting

class AppState extends ChangeNotifier {
  List<Logs> _unlockEvents = [];
  Map<String, int> _unlocksPerDay = {};
  String _currentUser = '';

  List<Logs> get unlockEvents => _unlockEvents;
  Map<String, int> get unlocksPerDay => _unlocksPerDay;
  String get currentUser => _currentUser;

  static DynamoDB getDynamoDBClient() {
    String region = 'us-east-1';

    final AwsClientCredentials credentials = AwsClientCredentials();
    final service = 'dynamodb';
    final endpoint = 'https://dynamodb.$region.amazonaws.com';
    final awsSigV4Client = AwsSigV4Client(
      credentials.secretKey,
      endpoint,
      region: region,
      serviceName: service,
    );

    return DynamoDB(
      region: region,
      credentials: credentials,
      client: http.Client(),
    );
  }

  Future<void> fetchUnlockEvents() async {
    try {
      // Get the current user
      final currentUser = await Amplify.Auth.getCurrentUser();
      final username = switch (currentUser.signInDetails) {
        CognitoSignInDetailsApiBased(:final username) => username,
        _ => currentUser.username,
      };
      _currentUser = username.split('@')[0];

      try {
        final dynamoDB = getDynamoDBClient();
        final response = await dynamoDB.scan(
          tableName: 'logs-unlocks',
          filterExpression: 'username = :v_username',
          expressionAttributeValues: {
            ':v_username': AttributeValue(s: _currentUser),
          },
        );

        final items = response.items;
        if (items != null) {
          for (var item in items) {
            final action = item['action']?.s ?? '';
            final timestampString = item['timestamp']?.s ?? '';

            TemporalDateTime timestamp;
            try {
              timestamp = TemporalDateTime(DateTime.parse(timestampString));
            } catch (e) {
              print('Error parsing timestamp: $e');
              continue; // Skip this entry if there's an error parsing the timestamp
            }

            final newLog = Logs(
              action: action,
              timestamp: timestamp,
              username: _currentUser,
            );

            await Amplify.DataStore.save(newLog);
          }
        }
      } catch (e) {
        print('Error adding log: $e');
      }

      // Fetch unlock events for the current user
      List<Logs> events = await Amplify.DataStore.query(
        Logs.classType,
        where: Logs.USERNAME.eq(_currentUser).and(Logs.TIMESTAMP
            .gt(TemporalDateTime(DateTime.now().subtract(Duration(days: 30))))),
        sortBy: [Logs.TIMESTAMP.descending()],
      );

      _unlockEvents = events;
      _prepareUnlocksPerDay();
      notifyListeners();
    } catch (e) {
      print('Error fetching unlock events: $e');
    }
  }

  void _prepareUnlocksPerDay() {
    _unlocksPerDay.clear();
    for (var event in _unlockEvents) {
      String date =
          DateFormat('yyyy-MM-dd').format(event.timestamp.getDateTimeInUtc());
      if (_unlocksPerDay.containsKey(date)) {
        _unlocksPerDay[date] = _unlocksPerDay[date]! + 1;
      } else {
        _unlocksPerDay[date] = 1;
      }
    }
  }
}
