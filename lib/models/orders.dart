// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import 'medicine.dart';
//
// class OrderItem {
//   final String id;
//   final double amount;
//   final List<Medicine> products;
//   final DateTime dateTime;
//
//   OrderItem({
//     required this.id,
//     required this.amount,
//     required this.products,
//     required this.dateTime,
//   });
// }
//
// class Orders with ChangeNotifier {
//   List<OrderItem> oorders = [];
//   final String? authtoken;
//   final String? userid;
//
//
//   Orders(this.authtoken, this.userid, this.oorders);
//
//   List<OrderItem> get orders {
//     return [...oorders];
//   }
//
//   Future<void> fechAndSetOrders() async {
//     var url = Uri.parse(
//         'https://artful-striker-383809-default-rtdb.firebaseio.com/orders/$userid.json?auth=$authtoken');
//     final response = await http.get(url);
//     final List<OrderItem> LoadedOrders = [];
//     final extractedData = jsonDecode(response.body) as Map<String, dynamic>;
//     if (extractedData != null) {
//       extractedData.forEach((orderID, orderData) {
//         LoadedOrders.add(OrderItem(
//           id: orderID,
//           amount: orderData['amount'],
//           products: (orderData['products'] as List<dynamic>)
//               .map((item) =>
//               CartItem(
//                   id: item['id'],
//                   title: item['title'],
//                   quantity: item['quantity'],
//                   price: item['price'])).toList(),
//           dateTime: DateTime.parse(orderData['dateTime']),
//
//         ));
//       });
//       oorders = LoadedOrders.reversed.toList();
//       notifyListeners();
//     }
//
//     else {
//       return;
//     }
//   }
// }