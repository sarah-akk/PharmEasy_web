import 'package:flutter/material.dart';
import '../warehouse_owner_widgets/cards_list.dart';
import '../warehouse_owner_widgets/custom_text.dart';
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
                                  CustomText(text: 'Top Buyers', size: 30),
                                  // TopBuyerWidget(),
                                  // TopBuyerWidget(),
                                  // TopBuyerWidget(),
                                  // TopBuyerWidget(),
                                  // TopBuyerWidget(),
                                  // TopBuyerWidget(),
                                  // TopBuyerWidget(),
                                  // TopBuyerWidget(),
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
