import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:home_eyes/aws/homepage/homepage.dart';
import 'package:provider/provider.dart';

import 'package:home_eyes/aws/app_state.dart';
import 'package:home_eyes/styleguide.dart';
import 'package:home_eyes/aws/login/uihelper.dart';
import 'package:home_eyes/aws/login/loginpage.dart';
import 'package:home_eyes/aws/ui/bottomtab.dart';
import 'package:home_eyes/aws/ui/fancybuttons.dart';
import 'package:home_eyes/aws/ui/fav_background.dart';


class DoorLockPage extends StatelessWidget {
  

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
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: Text(
                            "DoorLock Page",
                            style: fadedTextStyle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              FancyButton(
                                title: "Lock Door",
                                description: "Manually lock the door",
                                duration: "Tap to lock",
                                page: "Lock",
                              ),
                              SizedBox(height: 20),
                              FancyButton(
                                title: "Unlock Door",
                                description: "Manually unlock the door",
                                duration: "Tap to unlock",
                                page: "Unlock",
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Last 10 Unlocks",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              DataTable(
                                columns: [
                                  DataColumn(label: Text('Date')),
                                  DataColumn(label: Text('Method')),
                                ],
                                rows: [
                                  DataRow(cells: [
                                    DataCell(Text('2024-04-01')),
                                    DataCell(Text('Face ID')),
                                  ]),
                                  // Add more rows as needed
                                ],
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  // Implement navigation to full logs page or show a dialog with full logs
                                },
                                child: Text('View Full Logs'),
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Unlock Events per Day",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
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
          ],
        ),
      ),
      bottomNavigationBar: BottomTabs(
        UniqueKey(),
        1,
      ),
    );
  }
}

