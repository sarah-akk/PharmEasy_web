import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/orders.dart';
import '../warehouse_owner_widgets/drawer.dart';
import '../warehouse_owner_widgets/order_item.dart';
import '../warehouse_owner_widgets/page_header.dart';
import '../warehouse_owner_widgets/top_bar.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/OrdersScreen';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late List<OrderItem> orders;
  var isLoading = false;

  void initState(){
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        isLoading=true;
      });
       await Provider.of<Orders>(context,listen: false).fetchOrders();
      setState(() {
        isLoading=false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final orderData = Provider.of<Orders>(context);

    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          mydrawer(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  TopBar(),
                  PageHeader(text: "Orders"),
                  // Display the list of products
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: orderData != null
                        ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: orderData.orders.length,
                      itemBuilder: (context, index) {
                        return ProductListItem(orderData.orders[index]);
                      },
                    )
                        : CircularProgressIndicator(), // Show a loading indicator while data is being fetched
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


