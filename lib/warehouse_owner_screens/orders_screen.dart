import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../warehouse_owner_widgets/drawer.dart';
import '../warehouse_owner_widgets/page_header.dart';
import '../warehouse_owner_widgets/top_bar.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/OrdersScreen';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
          children: [
            mydrawer(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TopBar(),
                      PageHeader(text: "Orders"),
                    ]),

              ),
            ),
          ]),
    );

  }

}