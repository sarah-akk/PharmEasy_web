import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medicine_warehouse/Lang/Locale_keys_.g.dart';
import 'package:medicine_warehouse/models/medicines.dart';
import 'package:medicine_warehouse/models/orders.dart';
import 'package:provider/provider.dart';

import '../models/medicine.dart';
import 'card_item.dart';

class CardsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        Provider.of<Orders>(context, listen: false).fetchOrders(),
        Provider.of<MedicinesList>(context, listen: false).fetchMedicines(0),
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // You can show a loading indicator while fetching data
        } else if (snapshot.hasError) {
          return Text('Error loading data');
        } else {
          List<OrderItem> orders = Provider.of<Orders>(context).orders;
          List<Medicine> medicines = Provider.of<MedicinesList>(context).items;

          double medicinesLength = medicines.length.toDouble();
          double ordersLength = orders.length.toDouble();

          double revenue = 0.0;
          for (var order in orders) {
            for (var medicine in medicines) {
              revenue += medicine.price * medicine.quantityAvailable;
            }
          }

          return Container(
            height: 120,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CardItem(
                    icon: Icons.monetization_on_outlined,
                    title: LocaleKeys.Revenue.tr(),
                    subtitle: LocaleKeys.Revenue_this_month.tr(),
                    value: '\$${double.parse(revenue.toStringAsFixed(2))}',
                    color1: Colors.green.shade700,
                    color2: Colors.green,
                  ),
                  CardItem(
                    icon: Icons.shopping_basket_outlined,
                    title: LocaleKeys.Products.tr(),
                    subtitle: LocaleKeys.Total_products_on_store.tr(),
                    value: medicinesLength.toString(),
                    color1: Colors.lightBlueAccent,
                    color2: Colors.blue,
                  ),
                  CardItem(
                    icon: Icons.delivery_dining,
                    title: LocaleKeys.Orders.tr(),
                    subtitle: LocaleKeys.Total_orders_for_this_month.tr(),
                    value: ordersLength.toString(),
                    color1: Colors.pink,
                    color2: Colors.pinkAccent,
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
