// report_item.dart
import 'package:flutter/material.dart';

class ReportItem extends StatelessWidget {
  final int orderId;
  final int userId;
  final String status;
  final int paidStatus;
  final DateTime createdAt;
  final DateTime updatedAt;

  ReportItem({
    required this.orderId,
    required this.userId,
    required this.status,
    required this.paidStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Order ID: $orderId'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('User ID: $userId'),
          Text('Status: $status'),
          Text('Paid Status: ${paidStatus == 1 ? 'Paid' : 'Not Paid'}'),
          Text('Created At: $createdAt'),
          Text('Updated At: $updatedAt'),
        ],
      ),
      onTap: () {
        _showOrderDetails(context);
      },
    );
  }

  void _showOrderDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Order Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Order ID: $orderId'),
              Text('User ID: $userId'),
              Text('Status: $status'),
              Text('Paid Status: ${paidStatus == 1 ? 'Paid' : 'Not Paid'}'),
              Text('Created At: $createdAt'),
              Text('Updated At: $updatedAt'),
            ],
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
