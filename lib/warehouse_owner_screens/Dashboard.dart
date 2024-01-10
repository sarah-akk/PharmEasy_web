import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medicine_warehouse/Lang/Locale_keys_.g.dart';
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
    Provider.of<Orders>(context, listen: false).fetchOrders();

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
                      PageHeader(text: tr("dashboard")),
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
                                    tr("Reports"),
                                    style: TextStyle(
                                      fontSize: 35,
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  SizedBox(height: 25),
                                  Divider(),
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
                                              title: LocaleKeys.Sales_Report.tr(),
                                              description: LocaleKeys.Sales_description.tr(),
                                              orderDetailsList: orderDetailsList,
                                            ),
                                            Divider(),
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
                                            ReportItem(
                                              title: LocaleKeys.Orders_in_2023.tr(),
                                              description: LocaleKeys.orders_description.tr(),
                                              orderDetailsList: orderDetailsList,
                                            ),
                                            Divider(),
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
  final String description;
  final List<OrderDetails> orderDetailsList;

  ReportItem({
    required this.title,
    required this.description,
    required this.orderDetailsList,
  });

  @override
  State<ReportItem> createState() => _ReportItemState();
}

class _ReportItemState extends State<ReportItem> {

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.title,
        style: TextStyle(color: Colors.indigoAccent, fontWeight: FontWeight.bold,fontSize:25 ),),
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
          title: Text(widget.title,style: TextStyle(color: Colors.pink,fontSize: 20,fontWeight: FontWeight.w900),),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Row(
               children: [
                 SizedBox(width: 200,),
                 Image.asset("assets/images/data.jpg"),
               ],
             ),
              SizedBox(height: 20,),
              Text(widget.description,style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold),),
              // Existing code for individual order details
              for (var orderDetails in widget.orderDetailsList)
                ListTile(
                  title: Text('${LocaleKeys.Order_ID.tr()}: ${orderDetails.orderId}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${LocaleKeys.Order_Status.tr()}: ${orderDetails.status}'),
                      Text('${LocaleKeys.paidstatuse.tr()}: ${orderDetails.paidStatus == 1
                          ? '${LocaleKeys.Paid.tr()}'
                          : '${LocaleKeys.Not_Paid.tr()}'}',
                      style: TextStyle(color: orderDetails.paidStatus == 1 ? Colors.green : Colors.red),),
                      Text('${LocaleKeys.Created_At.tr()}: ${orderDetails.createdAt.toString()}'),
                      Text('${LocaleKeys.Updated_At.tr()}: ${orderDetails.updatedAt.toString()}'),
                      if (orderDetails.totalPrice != null)
                        Text('${LocaleKeys.Total_Price.tr()}: \$${orderDetails.totalPrice
                            .toString()}'),
                    ],
                  ),
                ),
              if (widget.title=="Sales Report in 2023" || widget.title=="اجمالي المبيعات عام 2023" )
              ListTile(
                title: Text('${LocaleKeys.Where_was_the_total_number_of_orders.tr()}: ${calculateTotalOrders(
                    widget.orderDetailsList)}',style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold)),
              ),
              if (widget.title=="Sales Report in 2023" || widget.title=="اجمالي المبيعات عام 2023" )
                ListTile(
                title: Text('${LocaleKeys.and_The_total_profit_of_FarmEasy_was.tr()} : \$${calculateTotalPrice(
                    widget.orderDetailsList).toStringAsFixed(2)}',style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('${LocaleKeys.Close.tr()}'),
            ),
          ],
        );
      },
    );
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Function to calculate the total number of orders
int calculateTotalOrders(List<OrderDetails> orderDetailsList) {
  return orderDetailsList.length;
}

// Function to calculate the total price of all orders
double calculateTotalPrice(List<OrderDetails> orderDetailsList) {
  double totalPrice = 0.0;
  for (var orderDetails in orderDetailsList) {
    totalPrice += orderDetails.totalPrice;
  }
  return totalPrice;
}

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
