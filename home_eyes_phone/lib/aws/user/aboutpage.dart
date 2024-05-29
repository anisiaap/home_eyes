import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  Uri _url = Uri.parse('https://github.com/anisiaap');
  Uri _url2 = Uri.parse(
      "mailto:anisia.pirvulescu@student.upt.ro?subject=HomeEyes&body=");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "About Page",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              "Please feel free to contact us at anytime.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _launchURL2,
              child: Text('Contact Us'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _launchURL,
              child: Text('Github Page'),
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL() async => await canLaunchUrl(_url)
      ? await launchUrl(_url)
      : throw 'Could not launch $_url';

  void _launchURL2() async => await canLaunchUrl(_url2)
      ? await launchUrl(_url2)
      : throw 'Could not launch $_url2';
}
