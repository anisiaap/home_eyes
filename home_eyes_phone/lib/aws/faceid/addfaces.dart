import 'dart:io';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:home_eyes/models/FacePhotos.dart';
import 'package:image_picker/image_picker.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:aws_common/vm.dart';

class AddFaces extends StatefulWidget {
  @override
  _AddFacesState createState() => _AddFacesState();
}

class _AddFacesState extends State<AddFaces> {
  File? _image;
  TextEditingController titleController = TextEditingController();
  List<int> categoryIds = [0];

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _submit() async {
    //add image to s3
    if (_image != null) {
      final currentUser = await Amplify.Auth.getCurrentUser();
      final username = switch (currentUser.signInDetails) {
        CognitoSignInDetailsApiBased(:final username) => username,
        _ => currentUser.username,
      };
      final name = titleController.text;
      final finalname = name.replaceAll(' ', '_');
      String user = username.split('@')[0];
      final key = "$user/$finalname.jpg";
      final awsFile = AWSFilePlatform.fromFile(_image!);
      try {
        final result = await Amplify.Storage.uploadFile(
            localFile: awsFile,
            key: key,
            onProgress: (progress) {
              print("Upload Progress: ${progress.fractionCompleted}");
              setState(() {
                _progress = progress.fractionCompleted;
              });
            }).result;

        //final photoUrl = await Amplify.Storage.getUrl(key: key);

        final result2 = await Amplify.Storage.getUrl(
          key: key,
          options:
              const StorageGetUrlOptions(accessLevel: StorageAccessLevel.guest),
        ).result;
        final photoUrl = result2.url.toString();
        // await _updatePersonsTable(name, photoUrl.toString(),username );
        try {
          // Create a new Person object with the name and photoUrl
          final newPerson =
              FacePhotos(name: name, photo: photoUrl, user: username);
          // Save the new person to the DataStore
          await Amplify.DataStore.save(newPerson);
          print('Person added successfully: $name');
        } catch (e) {
          print('Error adding person: $e');
        }
      } on StorageException catch (e) {
        setState(() {
          _progress = -1;
        });
        print('No image selected.');
      }
    }
    Navigator.of(context).pop();
  }

  double _progress = -1.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Page"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Person's Name"),
            ),
            _image == null ? Text('No image selected.') : Image.file(_image!),
            ElevatedButton(
              onPressed: () => _pickImage(ImageSource.camera),
              child: Text('Select Image from Camera'),
            ),
            ElevatedButton(
              onPressed: () => _pickImage(ImageSource.gallery),
              child: Text('Select Image from Gallery'),
            ),
            Text("$_progress"),
            ElevatedButton(
              onPressed: _submit,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
