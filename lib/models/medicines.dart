import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'medicine.dart';
import 'package:provider/provider.dart';

class MedicinesList with ChangeNotifier {
  int id=0;
  List<Medicine> medicines = [
    // Medicine(
    //   id: 0,
    //   scientificName: 'Acetaminophen',
    //   commercialName: 'Tylenol',
      //   category: 'Pain Relief',
    //   manufacturer: 'Johnson & Johnson',
    //   quantityAvailable: 100,
    //   expiryDate: DateTime(2023, 12, 31),
    //   price: 10.99,
    //   isFavorite: false,
    //   imageUrl: "",
    // ),
    // Medicine(
    //   id: 1,
    //   scientificName: 'Ibuprofen',
    //   commercialName: 'Advil',
    //   category: 'Pain Relief',
    //   manufacturer: 'Pfizer',
    //   quantityAvailable: 80,
    //   expiryDate: DateTime(2023, 11, 30),
    //   price: 8.99,
    //   isFavorite: false,
    //   imageUrl: "",
    //
    // ),
    // Medicine(
    //   id: 2,
    //   scientificName: 'Cetirizine',
    //   commercialName: 'Zyrtec',
    //   category: 'Antihistamine',
    //   manufacturer: 'Johnson & Johnson',
    //   quantityAvailable: 50,
    //   expiryDate: DateTime(2023, 10, 31),
    //   price: 15.99,
    //   isFavorite: false,
    //   imageUrl: "",
    //
    // ),
    // Medicine(
    //   id: 3,
    //   scientificName: 'Omeprazole',
    //   commercialName: 'Prilosec',
    //   category: 'Antacid',
    //   manufacturer: 'AstraZeneca',
    //   quantityAvailable: 60,
    //   expiryDate: DateTime(2023, 9, 30),
    //   price: 12.99,
    //   isFavorite: false,
    //   imageUrl: "",
    //
    //
    // ),
    // Medicine(
    //   id: 4,
    //   scientificName: 'Amoxicillin',
    //   commercialName: 'Amoxil',
    //   category: 'Antibiotic',
    //   manufacturer: 'GlaxoSmithKline',
    //   quantityAvailable: 30,
    //   expiryDate: DateTime(2023, 8, 31),
    //   price: 18.99,
    //   isFavorite: false,
    //   imageUrl: "",
    //
    //
    // ),
    // Medicine(
    //   id: 5,
    //   scientificName: 'Loratadine',
    //   commercialName: 'Claritin',
    //   category: 'Antihistamine',
    //   manufacturer: 'Bayer',
    //   quantityAvailable: 40,
    //   expiryDate: DateTime(2023, 7, 31),
    //   price: 9.99,
    //   isFavorite: false,
    //   imageUrl: "",
    //
    //
    // ),
    // Medicine(
    //   id: 6,
    //   scientificName: 'Simvastatin',
    //   commercialName: 'Zocor',
    //   category: 'Cholesterol Lowering',
    //   manufacturer: 'Merck',
    //   quantityAvailable: 25,
    //   expiryDate: DateTime(2023, 6, 30),
    //   price: 14.99,
    //   isFavorite: false,
    //   imageUrl: "",
    //
    //
    // ),
    // Medicine(
    //   id: 7,
    //   scientificName: 'Metformin',
    //   commercialName: 'Glucophage',
    //   category: 'Diabetes Management',
    //   manufacturer: 'Bristol Myers Squibb',
    //   quantityAvailable: 35,
    //   expiryDate: DateTime(2023, 5, 31),
    //   price: 11.99,
    //   isFavorite: false,
    //   imageUrl: "",
    //
    // ),
    // Medicine(
    //   id: 8,
    //   scientificName: 'Albuterol',
    //   commercialName: 'Ventolin',
    //   category: 'Respiratory',
    //   manufacturer: 'GSK',
    //   quantityAvailable: 45,
    //   expiryDate: DateTime(2023, 4, 30),
    //   price: 16.99,
    //   isFavorite: false,
    //   imageUrl: "",
    //
    // ),
    // Medicine(
    //   id: 9,
    //   scientificName: 'Warfarin',
    //   commercialName: 'Coumadin',
    //   category: 'Anticoagulant',
    //   manufacturer: 'Bristol Myers Squibb',
    //   quantityAvailable: 20,
    //   expiryDate: DateTime(2023, 3, 31),
    //   price: 13.99,
    //   isFavorite: false,
    //   imageUrl: "",
    //
    // ),
  ];
  MedicinesList(this.medicines){
    notifyListeners();
  }
  notifyListeners();

  List<Medicine> get items {

    return [...medicines];
  }
  Medicine findById(int id) {
    return items.firstWhere((prod) => prod.id == id);
  }

  // Future<void> fetchAndSetMedicines([bool filterByUser = false]) async {
  //   var url = Uri.parse(
  //       'https://artful-striker-383809-default-rtdb.firebaseio.com/medicines.json?');
  //
  //   try {
  //     final response = await http.get(url);
  //     final extractedData = json.decode(response.body) as Map<String, dynamic>;
  //     if (extractedData == null) {
  //       return;
  //     }
  //     final List<Medicine> loadedProducts = [];
  //     extractedData.forEach((prodId, MedData) {
  //       loadedProducts.add(Medicine(
  //         id: prodId,
  //         scientificName:MedData['scientificName'],
  //         commercialName: MedData['commercialName'],
  //         category: MedData['category'],
  //         quantityAvailable: MedData['quantityAvailable'],
  //         manufacturer : MedData['manufacturer'],
  //         expiryDate: MedData['expiryDate'],
  //         price: MedData['price'],
  //         imageUrl: MedData['imageUrl'],
  //
  //       ));
  //     });
  //     medicines = loadedProducts;
  //     notifyListeners();
  //   } catch (error) {
  //     throw (error);
  //   }
  //
  // }

  Future<void> addMedicine(Medicine medicine) async {
    var url = Uri.parse(
        'https://artful-striker-383809-default-rtdb.firebaseio.com/products.json');
    try {
      final response = await http.post(url, body: json.encode(
          {
            'scientificName': medicine.scientificName,
            'commercialName' : medicine.commercialName,
            'category': medicine.category,
            'quantityAvailable' : medicine.quantityAvailable,
            'manufacturer': medicine.manufacturer,
            'expiryDate': medicine.expiryDate.toIso8601String(),
            'price' : medicine.price,
            'imageUrl':medicine.imageUrl,
          }
      ),);
      final newMedicine = Medicine(
        scientificName : medicine.scientificName,
        commercialName : medicine.commercialName,
        category: medicine.category,
        quantityAvailable: medicine.quantityAvailable,
        manufacturer: medicine.manufacturer,
        expiryDate: medicine.expiryDate,
        price : medicine.price,
        imageUrl:medicine.imageUrl,
        id: id++,
      );
      medicines.add(newMedicine);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
      print("ok");
    }
    catch(error){
      print(error);
      throw error;
    }


  }

}
