import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:home_eyes/aws/app_state.dart';
import 'package:home_eyes/styleguide.dart';
import 'package:home_eyes/aws/ui/bottomtab.dart';
import 'package:home_eyes/aws/ui/fancybuttons.dart';
import 'package:home_eyes/aws/ui/fav_background.dart';

class FaceIdPage extends StatelessWidget {

  
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<AppState>(
        create: (_) => AppState(),
        child: Stack(
          children: <Widget>[
            FavePageBackground(
              screenHeight: MediaQuery.of(context).size.height,
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "FaceID Page",
                            style: fadedTextStyle,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          FancyButton(
                              title: "View Persons",
                              description: "View persons from database",
                              duration: "Tap to view",
                              page: "PersonListPage",),
                          SizedBox(height: 20),
                          FancyButton(
                              title: "Add Person",
                              description: "Add new person",
                              duration: "Tap to add",
                              page: "AddFaces"),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomTabs(
        UniqueKey(),
        2,
      ),
    );
  }
}
