import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'cart.dart';

class OrderItem {
  final int id;
  final double  amount;
  final List<CartItem> products;
  final String dateTime;
  final String phone;
   String status;
   bool paymentStatus;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
    required this.phone,
    required this.status,
    required this.paymentStatus,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> oorders = [];
  final String? authtoken;
  final String? userid;

  Orders(this.authtoken, this.userid, this.oorders) {
    notifyListeners();
  }
  notifyListeners();

  List<OrderItem> get orders {
    return [...oorders];
  }

  double calculateTotalAmount(List<CartItem> products) {
    return products.fold(
        0.0, (sum, product) => sum + (product.quantity * product.price));
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Future<void> fetchOrders() async {
    var url = Uri.parse('http://127.0.0.1:8000/api/viewAdmin');

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authtoken',
    });

    print(response.body);
    final List<OrderItem> loadedOrders = [];
    final extractedData = jsonDecode(response.body) as Map<String, dynamic>;

    if (extractedData['status'] == 200) {
      final orderList = extractedData['data']['orders'] as List<dynamic>;

      orderList.forEach((orderData) {
        final List<CartItem> orderProducts = (orderData['medicines'] as List<
            dynamic>)
            .map((medicine) =>
            CartItem(
              id: DateTime.now().toString(),
              title: medicine['commercial_name'],
              quantity: medicine['pivot']['request_quantity'].toDouble(),
              price: medicine['price'].toDouble(),
            ))
            .toList();

        loadedOrders.add(OrderItem(
          id: orderData['id'],
          amount: calculateTotalAmount(orderProducts),
          products: orderProducts,
          dateTime: orderData['created_at'],
          status: orderData['status'],
          paymentStatus: orderData['paid_status'] == 1,
          phone: orderData['user']['phone'],
        ));
      });

      oorders = loadedOrders.reversed.toList();
      print(oorders);
      notifyListeners();
    }
  }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Future<void> changeOrderStatus(int orderId, String newStatus) async {
    final apiUrl = 'http://127.0.0.1:8000/api/changeOrder/$orderId';
    print('orderId $orderId newStatus $newStatus');// Update the URL with your actual endpoint

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authtoken', // Include your authentication token here
        },
        body: jsonEncode({
          'status': newStatus,
        }),
      );

      if (response.statusCode == 200) {
        print('Order status changed successfully');
      } else {
        print('Failed to change order status. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (error) {
      print('Error occurred while changing order status: $error');
    }
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Future<void> changePaymentStatus(int orderId, bool newPaymentStatus) async {

    print('orderId $orderId newStatus $newPaymentStatus');// Update the URL with your actual endpoint

    final apiUrl = 'http://127.0.0.1:8000/api/changeOrderPaid/$orderId'; // Replace with your actual API endpoint

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authtoken', // Include your authentication token here
        },
        body: jsonEncode({
          'paid_status': newPaymentStatus,
        }),
      );

      if (response.statusCode == 200) {
        print('Payment status changed successfully');
      } else {
        print('Failed to change payment status. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (error) {
      print('Error occurred while changing payment status: $error');
    }
  }

}