import 'package:flutter/material.dart';
import 'package:home_eyes/aws/app_state.dart';
import 'package:home_eyes/aws/doorlock/charts.dart';
import 'package:provider/provider.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:home_eyes/models/ModelProvider.dart';
import 'package:home_eyes/aws/ui/bottomtab.dart';
import 'package:home_eyes/aws/ui/fancybuttons.dart';
import 'package:home_eyes/aws/ui/fav_background.dart';
import 'package:home_eyes/styleguide.dart';

class DoorLockPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      body: ChangeNotifierProvider<AppState>(
        create: (_) {
          AppState appState = AppState();
          appState.fetchUnlockEvents(); // Fetch unlock events on initialization
          return appState;
        },
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
                              Consumer<AppState>(
                                builder: (context, state, child) {
                                  return DataTable(
                                    columns: [
                                      DataColumn(label: Text('Date')),
                                      DataColumn(label: Text('Method')),
                                    ],
                                    rows: state.unlockEvents.map((event) {
                                      return DataRow(cells: [
                                        DataCell(Text(event.timestamp
                                            .format())), // Assuming you have a format method
                                        DataCell(Text(event.action)),
                                      ]);
                                    }).toList(),
                                  );
                                },
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
                              SizedBox(height: 20),
                              UnlockEventsBarChart(),
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
