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
  // Sample data for testing
  final List<Product> products = [
    Product(name: 'Product 1', price: 19.99, index: 0),
    Product(name: 'Product 2', price: 29.99, index: 1),
    Product(name: 'Product 3', price: 39.99, index: 2),
    Product(name: 'Product 4', price: 39.99, index: 3),
    Product(name: 'Product 4', price: 39.99, index: 4),
    Product(name: 'Product 4', price: 39.99, index: 5),


    // Add more sample products as needed
  ];

  @override
  Widget build(BuildContext context) {
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
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return ProductListItem(product: products[index]);
                      },
                    ),
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

class ProductListItem extends StatefulWidget {
  final Product product;

  ProductListItem({required this.product});

  @override
  State<ProductListItem> createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem> {
  bool isPaid = false; // Initial value for the payment status
  final List<Color> contactColors = [
    Colors.pinkAccent.withOpacity(0.6),
    Colors.yellowAccent.withOpacity(0.6),
    Colors.lightBlueAccent.withOpacity(0.6),
    Colors.purpleAccent.withOpacity(0.6),
  ];

  @override
  Widget build(BuildContext context) {
    // Calculate the index to get a sequential color
    int colorIndex = widget.product.index % contactColors.length;

    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      shadowColor: Colors.black45,
      child: ListTile(
        title: DefaultTextStyle(
          style: TextStyle(color: Colors.black),
          child: Container(
            width: 200,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: contactColors[colorIndex],
            ),
            child: Text(
              '${widget.product.name} - Contact: XXX-XXX-XXXX',
            ),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Price: \$${widget.product.price.toStringAsFixed(2)}'),
            Text('Order Status: ${isPaid ? 'Received' : 'Sent'}'),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () {
            // Handle the button press to change the payment status
            setState(() {
              isPaid = !isPaid;
            });
          },
          style: ElevatedButton.styleFrom(
            primary: isPaid ? Colors.green : Colors.red,
          ),
          child: Text(isPaid ? 'Paid' : 'Not Paid'),
        ),
      ),
    );
  }
}

// Sample Product class
class Product {
  final String name;
  final double price;
  final int index; // Add the index property

  Product({required this.name, required this.price, required this.index});
}
