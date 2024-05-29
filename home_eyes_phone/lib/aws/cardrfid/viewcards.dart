import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:path_provider/path_provider.dart';

class CardListPage extends StatefulWidget {
  @override
  _CardListPageState createState() => _CardListPageState();
}

class _CardListPageState extends State<CardListPage> {
  List<String> _cardIds = [];

  @override
  void initState() {
    super.initState();
    fetchCardIds();
  }

  Future<void> fetchCardIds() async {
    try {
      final currentUser = await Amplify.Auth.getCurrentUser();
      final username = switch (currentUser.signInDetails) {
        CognitoSignInDetailsApiBased(:final username) => username,
        _ => currentUser.username,
      };
      String user = username.split('@')[0];
      final key = '$user/cards.txt';

      final result = await Amplify.Storage.downloadData(
          key: key,
          onProgress: (progress) {
            print("Upload Progress: ${progress.fractionCompleted}");
          }).result;
      final fileContent = String.fromCharCodes(result.bytes);
      final cardIds =
          fileContent.split('\n').map((e) => e.trim()).toSet().toList();

      setState(() {
        _cardIds = cardIds;
      });
    } on StorageException catch (e) {
      print('Error downloading file: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card List'),
      ),
      body: _cardIds.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Card ID')),
                ],
                rows: _cardIds
                    .map(
                      (cardId) => DataRow(
                        cells: [
                          DataCell(Text(cardId)),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
    );
  }
}
