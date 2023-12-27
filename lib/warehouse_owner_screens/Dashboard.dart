import 'package:flutter/material.dart';
import '../warehouse_owner_widgets/cards_list.dart';
import '../warehouse_owner_widgets/drawer.dart';
import '../warehouse_owner_widgets/page_header.dart';
import '../warehouse_owner_widgets/sales_chart.dart';
import '../warehouse_owner_widgets/top_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePageDesktop(),
    );
  }
}

class HomePageDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Navigation bar on the left
          mydrawer(),
          // Content area
          Expanded(
            child: Column(
              children: [
                TopBar(),
                // Content
                Expanded(
                  child: ListView(
                    children: [
                      PageHeader(text: "DASHBOARD"),
                      CardsList(),
                      Padding(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 600,
                              width: MediaQuery.of(context).size.width / 1.9,
                              child: SalesChart(),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 4,
                              height: 600,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0, 3),
                                    blurRadius: 16,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 10),
                                  Text(
                                    'Reports',
                                    style: TextStyle(
                                      fontSize: 35,
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  // First Report
                                  ReportItem(
                                    title: 'Sales Report',
                                    description:
                                    'View sales during a specific period of time.',
                                  ),
                                  // Second Report
                                  ReportItem(
                                    title: 'Orders Report',
                                    description:
                                    'View orders during a specific period of time.',
                                  ),
                                ],
                              ),
                            )
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
    );
  }
}

class ReportItem extends StatelessWidget {
  final String title;
  final String description;

  ReportItem({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(description),
      onTap: () {
        _showReportDetails(context, title, description);
      },
    );
  }

  void _showReportDetails(BuildContext context, String title, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(description),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
