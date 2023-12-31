import 'package:flutter/material.dart';
import 'package:medicine_warehouse/models/medicines.dart';
import 'package:provider/provider.dart';
import '../models/orders.dart';
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

class HomePageDesktop extends StatefulWidget {
  @override
  State<HomePageDesktop> createState() => _HomePageDesktopState();
}

class _HomePageDesktopState extends State<HomePageDesktop> {
  late Future<List<OrderDetails>> orders2023;
  late Future<List<OrderDetails>> salesReport;

  @override
  void initState() {
    super.initState();
    orders2023 = Provider.of<Orders>(context, listen: false).fetchOrdersreport();
    salesReport = Provider.of<Orders>(context, listen: false).fetchSalesreport();
  }

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
                                  SizedBox(height: 20),
                                  Text(
                                    'Reports',
                                    style: TextStyle(
                                      fontSize: 35,
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  FutureBuilder<List<OrderDetails>>(
                                    future: orders2023,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        return Text('Error loading data');
                                      } else {
                                        final orderDetailsList = snapshot.data!;
                                        return Column(
                                          children: [
                                            SizedBox(height: 10),
                                            ReportItem(
                                              title: 'Orders in 2023',
                                              orderDetailsList: orderDetailsList,
                                            ),
                                          ],
                                        );
                                      }
                                    },
                                  ),
                                  // FutureBuilder for the second set of data
                                  FutureBuilder<List<OrderDetails>>(
                                    future: salesReport,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        return Text('Error loading data');
                                      } else {
                                        final orderDetailsList = snapshot.data!;
                                        return Column(
                                          children: [
                                            SizedBox(height: 10),
                                            ReportItem(
                                              title: 'Sales Report',
                                              orderDetailsList: orderDetailsList,
                                            ),
                                          ],
                                        );
                                      }
                                    },
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
        ],
      ),
    );
  }
}


class ReportItem extends StatefulWidget {
  
  final String title;
  final List<OrderDetails> orderDetailsList;

  ReportItem({
    required this.title,
    required this.orderDetailsList,
  });

  @override
  State<ReportItem> createState() => _ReportItemState();
}

class _ReportItemState extends State<ReportItem> {

  @override
  Widget build(BuildContext context) {
    
    
    return ListTile(
      title: Text(widget.title,style: TextStyle(color: Colors.teal,fontWeight: FontWeight.bold),),
      onTap: () {
        _showReportDetails(context);
      },
    );
  }

  void _showReportDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(widget.title),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.orderDetailsList.map((orderDetails) {
              return ListTile(
                title: Text('Order ID: ${orderDetails.orderId}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Status: ${orderDetails.status}'),
                    Text('Paid Status: ${orderDetails.paidStatus == 1 ? 'Paid' : 'Not Paid'}'),
                    Text('Created At: ${orderDetails.createdAt.toString()}'),
                    Text('Updated At: ${orderDetails.updatedAt.toString()}'),
                    if (orderDetails.totalPrice != null) // Check if the field exists
                      Text('Total Price: ${orderDetails.totalPrice.toString()}'),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  // Handle additional action when tapping an order within the list
                },
              );
            }).toList(),
          ),
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

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class OrderDetails {
  final int orderId;
  final int userId;
  final String status;
  final int paidStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final double totalPrice; // New field for the second API

  OrderDetails({
    required this.orderId,
    required this.userId,
    required this.status,
    required this.paidStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.totalPrice,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
      orderId: json['id'],
      userId: json['user_id'],
      status: json['status'],
      paidStatus: json['paid_status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      totalPrice: json['total_price'] ?? 0.0, // Assuming 'total_price' is the key for the new field
    );
  }
}
