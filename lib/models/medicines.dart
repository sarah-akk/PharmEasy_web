import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'medicine.dart';
import 'package:provider/provider.dart';

class MedicinesList with ChangeNotifier {

  int id=0;
  List<Medicine> medicines = [];
  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  final String? authToken;
  final String? userId;

  MedicinesList(this.authToken,this.userId,this.medicines){
    notifyListeners();
  }
  notifyListeners();

  List<Medicine> get items {

    return [...medicines];
  }

  Medicine findById(int id) {
    return items.firstWhere((prod) => prod.id == id);
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Future<void> fetchMedicines(int categoryNumber) async {

    print('categoryNumber : ${categoryNumber}');
    print('aa$authToken');

    if(categoryNumber == 0) {
      var url = Uri.parse('http://127.0.0.1:8000/api/showAll');
      try {
        final response = await http.get(
          url,  headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        );

        Map<String, dynamic> jsonDataMap = json.decode(response.body);
        List<dynamic> data = jsonDataMap['data'];

        print(jsonDataMap);

        List<Medicine> medicinesData = data.map((medData) {
          return Medicine(
            id: medData['id'],
            scientificName: medData['scientific_name'],
            commercialName: medData['commercial_name'],
            category: medData['category_id'],
            manufacturer: medData['manufacture_company'],
            quantityAvailable: medData['available_quantity'],
            expiryDate: medData['expiration_date'],
            price: medData['price'].toDouble(),
            imageUrl: medData['photo'],
            isfavorate: false,
          );
        }).toList();
        print('medicinesData lenght : ${medicinesData.length}');
        medicines = medicinesData;
        notifyListeners();
      } catch (error) {
        throw (error);
      }
    }
    else
      {
        var url = Uri.parse('http://127.0.0.1:8000/api/medicines_category_Id/$categoryNumber');

        try {
          final response = await http.get(
            url,   headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $authToken',
          },
          );
          Map<String, dynamic> jsonDataMap = json.decode(response.body);
          List<dynamic> data = jsonDataMap['data'];

          List<Medicine> medicinesData = data.map((medData) {
            return Medicine(
              id: medData['id'],
              scientificName: medData['scientific_name'],
              commercialName: medData['commercial_name'],
              category:(medData['category_id']),
              manufacturer: medData['manufacture_company'],
              quantityAvailable: medData['available_quantity'],
              expiryDate: medData['expiration_date'],
              price: medData['price'],
              imageUrl: medData['photo'],
              isfavorate: false,
            );
          }).toList();

          print('medicinesData lenght : ${medicinesData.length}');
          medicines = medicinesData;
          notifyListeners();
        } catch (error) {
          throw (error);
        }
      }
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


  Future<void> addMedicine(Medicine medicine) async {

    print('ss$authToken');

    var url = Uri.parse('http://127.0.0.1:8000/api/store');
    try {
      final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
          body: json.encode(
          {
            'scientific_name': medicine.scientificName,
            'commercial_name' : medicine.commercialName,
            'category_id': medicine.category,
            'manufacture_company': medicine.manufacturer,
            'available_quantity' : medicine.quantityAvailable,
            'expiration_date': medicine.expiryDate,
            'price' : medicine.price,
            'photo':medicine.imageUrl,
          }
      ),
      );
      print(response.body);
    // print(response.statusCode);
    // print(response.body);
    final newMedicine = Medicine(
        id:id++,
        scientificName : medicine.scientificName,
        commercialName : medicine.commercialName,
        category: medicine.category,
        quantityAvailable: medicine.quantityAvailable,
        manufacturer: medicine.manufacturer,
        expiryDate: medicine.expiryDate,
        price : medicine.price,
        imageUrl:medicine.imageUrl,
        isfavorate:false,
      );
      medicines.add(newMedicine);
      notifyListeners();
    }
    catch(error){
      print(error);
      throw error;
    }
  }


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Future<void> getSearch(String searchQuery) async {

  print(searchQuery);
  var url = Uri.parse(
      'http://127.0.0.1:8000/api/search');
  try {
    final response = await http.post(
        url,   headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken',
        },
        body: json.encode(
            {
              'name': searchQuery,
            }
        )
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonDataMap = json.decode(response.body);
      if (jsonDataMap['data'] != null &&
          jsonDataMap['data'] is Map<String, dynamic>) {
        Map<String, dynamic> data = jsonDataMap['data'];

        Medicine medicine = Medicine(
          id: data['id'],
          scientificName: data['scientific_name'],
          commercialName: data['commercial_name'],
          category: data['category_id'],
          manufacturer: data['manufacture_company'],
          quantityAvailable: data['available_quantity'].toDouble(),
          expiryDate: data['expiration_date'],
          price: data['price'].toDouble(),
          imageUrl: data['photo'],
          isfavorate: data['favorite'] == 1,
        );
       print(medicine);
        medicines.clear();
        medicines.add(medicine);
        _isLoading = false;
        notifyListeners();
      }
    }
  }
  catch (error) {
    throw (error);
  }
}
}
////////////////////////////////////////////////////////////////////////////////////////////////////
//   Future<void> fetchAndSetMedicines([bool filterByUser = false]) async {
//
//     //final filterString = filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
//     var url = Uri.parse(
//         'https://artful-striker-383809-default-rtdb.firebaseio.com/medicines.json?auth=$authToken');
//     try {
//       final response = await http.get(url);
//       final extractedData = json.decode(response.body) as Map<String, dynamic>;
//       print(response.body);
//       if (extractedData == null) {
//         return;
//       }
//       final List<Medicine> loadedProducts = [];
//       extractedData.forEach((prodId, MedData) {
//         loadedProducts.add(Medicine(
//           id: id++,
//           scientificName:MedData['scientific_name'],
//           commercialName: MedData['commercial_name'],
//           category: MedData['category'],
//           quantityAvailable: MedData['available_quantity'],
//           manufacturer : MedData['manufacture_company'],
//           expiryDate: DateTime.parse(MedData['expiration_date']),
//           price: MedData['price'],
//           imageUrl: MedData['photo'],
//           isfavorate: MedData['favorite'],
//         ));
//       });
//       medicines = loadedProducts;
//      // print(loadedProducts.length);
//       notifyListeners();
//     } catch (error) {
//       throw (error);
//     }
//   }
//   /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//   Future<void> addMedicine(Medicine medicine) async {
//
//     var url = Uri.parse('https://artful-striker-383809-default-rtdb.firebaseio.com/medicines.json?auth=$authToken');
//     try {
//       final response = await http.post(url, body: json.encode(
//           {
//             'scientific_name': medicine.scientificName,
//             'commercial_name' : medicine.commercialName,
//             'category': medicine.category,
//             'manufacture_company': medicine.manufacturer,
//             'available_quantity' : medicine.quantityAvailable,
//             'expiration_date': medicine.expiryDate.toIso8601String(),
//             'price' : medicine.price,
//             'photo':medicine.imageUrl,
//             'favorite':medicine.isfavorate,
//           }
//       ),
//       );
//       final newMedicine = Medicine(
//         id:id++,
//         scientificName : medicine.scientificName,
//         commercialName : medicine.commercialName,
//         category: medicine.category,
//         quantityAvailable: medicine.quantityAvailable,
//         manufacturer: medicine.manufacturer,
//         expiryDate: medicine.expiryDate,
//         price : medicine.price,
//         imageUrl:medicine.imageUrl,
//         isfavorate:medicine.isfavorate,
//       );
//       medicines.add(newMedicine);
//       print(medicines.length);
//       notifyListeners();
//       print("ok");
//     }
//     catch(error){
//       print(error);
//       throw error;
//     }
//   }
//
// }
