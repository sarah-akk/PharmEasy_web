import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine_warehouse/Lang/locale_keys.g.dart';
import 'package:provider/provider.dart';

import '../models/orders.dart';

class OrdersList extends StatelessWidget {

  final List<OrderItem> orders;
  OrdersList(this.orders);

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return ProductListItem(orders[index]);
      },
    );
  }
}

class ProductListItem extends StatefulWidget {
  final OrderItem order;

  ProductListItem(this.order);

  @override
  _ProductListItemState createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem> {
  String selectedStatus = 'Preparing'; // Initial value for the status
  bool isPaid = false; // Initial value for the payment status
  final List<Color> contactColors = [
    Colors.pinkAccent.withOpacity(0.6),
    Colors.yellowAccent.withOpacity(0.6),
    Colors.lightBlueAccent.withOpacity(0.6),
    Colors.purpleAccent.withOpacity(0.6),
  ];

  @override
  Widget build(BuildContext context) {

    int colorIndex = widget.order.id % contactColors.length;

    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      shadowColor: Colors.black45,
      child: ExpansionTile(
        title: DefaultTextStyle(
          style: TextStyle(color: Colors.black),
          child: Container(
            width: 200,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: contactColors[colorIndex],
            ),
              child: Text('${LocaleKeys.contact.tr()}:  ${LocaleKeys.name.tr()}: ${widget.order.name}     ${LocaleKeys.phone.tr()}: ${widget.order.phone}',style: TextStyle(color: Colors.black,fontSize: 19,),)
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${LocaleKeys.Total_Price.tr()}: \$${widget.order.amount.toStringAsFixed(2)}'),
            Row(
              children: [
                Text('${LocaleKeys.Order_Status.tr()}: '),
                DropdownButton<String>(
                  value: widget.order.status,
                  items: [
                    DropdownMenuItem<String>(
                      value: 'are preparing',
                      child: Text(LocaleKeys.are_preparing.tr()),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Sent',
                      child: Text(LocaleKeys.Sent.tr()),
                    ),
                    DropdownMenuItem<String>(
                      value: 'received',
                      child: Text(LocaleKeys.received.tr()),
                    ),
                  ],
                  onChanged: (String? selectedValue) async {
                    if (selectedValue != null) {
                      setState(() {
                        widget.order.status = selectedValue;
                      });
                      try {
                        await Provider.of<Orders>(context, listen: false).changeOrderStatus(widget.order.id, selectedValue);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Order status changed!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to change order status: $error'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        // Revert to the original status if there's an error
                        setState(() {
                          widget.order.status = widget.order.status;
                        });
                      }
                    }
                  },
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      widget.order.paymentStatus = !widget.order.paymentStatus;
                    });
                    try {
                      await Provider.of<Orders>(context, listen: false)
                          .changePaymentStatus(widget.order.id, widget.order.paymentStatus);
                    } catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to change payment status: $error'),
                          backgroundColor: Colors.red,
                        ),
                      );

                      // Revert to the original payment status
                      setState(() {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('payment status changed ! :'),
                              backgroundColor: Colors.red,
                            ),
                        );
                        widget.order.paymentStatus = !widget.order.paymentStatus;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: widget.order.paymentStatus ? Colors.green : Colors.red,
                  ),
                  child: Text(widget.order.paymentStatus ? LocaleKeys.Paid.tr() : LocaleKeys.Not_Paid.tr(),style: TextStyle(color: Colors.white70),),
                ),
              ],
            ),
          ],
        ),
        children: [
          // Display medicines here
          for (var product in widget.order.products)
            ListTile(
              title: Text('${LocaleKeys.name.tr()} : ${product.title}'),
              subtitle: Text('${LocaleKeys.Quantity.tr()} : ${product.quantity}'),
            ),
        ],
      ),
    );
  }
}
