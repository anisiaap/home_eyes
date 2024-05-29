import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class VideoStream extends StatefulWidget {
  @override
  _VideoStreamState createState() => _VideoStreamState();
}

class _VideoStreamState extends State<VideoStream> {
  final WebSocketChannel channel = WebSocketChannel.connect(
    Uri.parse('ws://localhost:8765'),  // Replace with your server address
  );

  Uint8List _imageData = Uint8List(0);  // Initialize with an empty byte array

  @override
  Widget build(BuildContext context) {
    return _imageData.isEmpty
        ? CircularProgressIndicator()
        : Image.memory(_imageData);
  }

  @override
  void initState() {
    super.initState();
    channel.stream.listen((data) {
      setState(() {
        _imageData = base64Decode(data);
      });
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}
