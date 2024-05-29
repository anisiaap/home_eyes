import 'dart:io';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
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

      } on StorageException {
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
