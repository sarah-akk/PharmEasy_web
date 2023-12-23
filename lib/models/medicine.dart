import 'package:flutter/foundation.dart';

class Medicine with ChangeNotifier {

  final  int id;
  final String scientificName;
  final String commercialName;
  final int category;
  final String manufacturer;
  final double quantityAvailable;
  final String expiryDate;
  final double price;
  final String imageUrl;
  final bool isfavorate;

  Medicine({

    required this.id,
    required this.scientificName,
    required this.commercialName,
    required this.category,
    required this.manufacturer,
    required this.quantityAvailable,
    required this.expiryDate,
    required this.price,
    required this.imageUrl,
    required this.isfavorate,
  });
}
