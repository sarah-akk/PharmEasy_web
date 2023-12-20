import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'medicine.dart';
import 'package:provider/provider.dart';

class MedicinesList with ChangeNotifier {

  int id=0;
  List<Medicine> medicines = [];
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

    if(categoryNumber == 0) {
      var url = Uri.parse('http://127.0.0.1:8000/api/showAll');
      try {
        final response = await http.get(
          url, headers: {'Content-Type': 'application/json'},);

        Map<String, dynamic> jsonDataMap = json.decode(response.body);
        List<dynamic> data = jsonDataMap['data'];

        List<Medicine> medicinesData = data.map((medData) {
          return Medicine(
            id: medData['id'],
            scientificName: medData['scientific_name'],
            commercialName: medData['commercial_name'],
            category: medData['categroy'],
            manufacturer: medData['manufacture_company'],
            quantityAvailable: medData['available_quantity'],
            expiryDate: medData['expiration_date'],
            price: medData['price'].toDouble(),
            imageUrl: medData['photo'],
            isfavorate: medData['favorite'] == 1,
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
        var url = Uri.parse('http://127.0.0.1:8000/api/medicines_category_Id/{categoryId}');

        try {
          final response = await http.get(
            url, headers: {'Content-Type': 'application/json'},);

          Map<String, dynamic> jsonDataMap = json.decode(response.body);
          List<dynamic> data = jsonDataMap['data'];

          List<Medicine> medicinesData = data.map((medData) {
            return Medicine(
              id: medData['id'],
              scientificName: medData['scientific_name'],
              commercialName: medData['commercial_name'],
              category: medData['categroy'],
              manufacturer: medData['manufacture_company'],
              quantityAvailable: medData['available_quantity'],
              expiryDate: medData['expiration_date'],
              price: medData['price'].toDouble(),
              imageUrl: medData['photo'],
              isfavorate: medData['favorite'] == 1,
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

  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Future<void> addMedicine(Medicine medicine) async {

    int categoryID =0;
    if(medicine.category=='Neurological medications')
      categoryID=1;
    else if(medicine.category=='Heart medications')
      categoryID=2;
    else if(medicine.category=='Anti-inflammatories')
      categoryID=3;
    else if(medicine.category=='Food supplements')
      categoryID=4;
    else
      categoryID=5;

    print(categoryID);
    var url = Uri.parse('http://127.0.0.1:8000/api/store');
    try {
      final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
          body: json.encode(
          {
            'scientific_name': medicine.scientificName,
            'commercial_name' : medicine.commercialName,
            'categroy': medicine.category,
            'manufacture_company': medicine.manufacturer,
            'available_quantity' : medicine.quantityAvailable,
            'expiration_date': medicine.expiryDate,
            'price' : medicine.price,
            'photo':medicine.imageUrl,
            'favorite':medicine.isfavorate,
          }
      ),
      );
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
        isfavorate:medicine.isfavorate,
      );
      medicines.add(newMedicine);
      notifyListeners();
    }
    catch(error){
      print(error);
      throw error;
    }
  }

}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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
