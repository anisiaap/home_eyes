import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:home_eyes/aws/app_state.dart';
import 'package:home_eyes/styleguide.dart';
import 'package:home_eyes/aws/login/uihelper.dart';
import 'package:home_eyes/aws/login/loginpage.dart';
import 'package:home_eyes/aws/ui/bottomtab.dart';
import 'package:home_eyes/aws/ui/fancybuttons.dart';
import 'package:home_eyes/aws/ui/fav_background.dart';

class CardRfidPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => AppState(),
        child: Stack(
          children: [
            FavePageBackground(
              screenHeight: MediaQuery.of(context).size.height,
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Row(
                        children: [
                          Text(
                            "RFID Page",
                            style: fadedTextStyle,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          FancyButton(
                            title: "View Cards",
                            description: "View RFID cards",
                            duration: "Tap to view",
                            page: "CardListPage",
                          ),
                          SizedBox(height: 20),
                          FancyButton(
                            title: "Add Card",
                            description: "Add new RFID card",
                            duration: "Tap to add",
                            page: "ReadCard",
                          ),
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
        3,
      ),
    );
  }
}
