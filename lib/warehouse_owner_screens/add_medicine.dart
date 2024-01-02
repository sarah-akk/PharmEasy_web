import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medicine_warehouse/Lang/Locale_keys_.g.dart';
import 'package:medicine_warehouse/models/medicine.dart';
import 'package:medicine_warehouse/models/medicines.dart';
import 'package:medicine_warehouse/warehouse_owner_widgets/page_header.dart';
import 'package:medicine_warehouse/warehouse_owner_widgets/top_bar.dart';
import 'package:provider/provider.dart';
import 'products_screen.dart';
import '../warehouse_owner_widgets/drawer.dart';

class MedicineAddScreen extends StatefulWidget {
  static const routeName = '/MedicineAddScreen';

  @override
  _MedicineAddScreenState createState() => _MedicineAddScreenState();
}

class _MedicineAddScreenState extends State<MedicineAddScreen> {

  final Scientific_Name_Node = FocusNode();
  final Commercial_Name_Node = FocusNode();
  final Category_Node = FocusNode();
  final Manufacturer_Node = FocusNode();
  final Quantity_Available_Node = FocusNode();
  final Expiry_Date_Node = FocusNode();
  final Price_Name_Node = FocusNode();
  final Img_Node = FocusNode();

  final _form = GlobalKey<FormState>();

  var _isloading = false;
  String? selectedCategory; // Add this variable to store the selected category
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////

  final Map<String, int> categoryMap = {
    'Neurological medications': 1,
    'Heart medications': 2,
    'Anti-inflammatories': 3,
    'Food supplements': 4,
    'Painkillers': 5,
  };

  var newMedicine = Medicine(
    id: 0,
    scientificName: '',
    commercialName: '',
    category: 0 ,
    manufacturer: '',
    quantityAvailable: 0,
    expiryDate: '',
    price: 0,
    imageUrl: '',
    isfavorate: false,
  );

  var _initValues = {
    'scientificName': '',
    'commercialName': '',
    'Category': 0 ,
    'manufacturer': '',
    'quantityAvailable': 0,
    'expiryDate': DateTime.now(),
    'price': 0,
    'imageUrl': '',
    'isfavorate':false,
  };

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Future<void> _saveForm() async {
    final isValid = _form.currentState?.validate();
    if (!isValid!) {
      print("no");
      return;
    }
    _form.currentState?.save();
    await Provider.of<MedicinesList>(context, listen: false)
        .addMedicine(newMedicine)
        .catchError((error) {
      return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occurred!'),
          content: Text(error.toString()),
          actions: <Widget>[
            FloatingActionButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(ProductsScreen.routeName);
              },
            )
          ],
        ),
      );
    });
    setState(() {
      _isloading = false;
    });
    Navigator.of(context).pushReplacementNamed(ProductsScreen.routeName);
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
            children: [

            mydrawer(),  // Add the drawer widget here
        Expanded(
        child: Column(
        children: [
          TopBar(),  // Add the TopBar widget here
          Expanded(
      child:  Stack(
        fit: StackFit.expand,
        children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20,),
            PageHeader(text: LocaleKeys.Add_medicine.tr()),
            SizedBox(height: 50,),
            SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 3),
                    blurRadius: 16,
                  ),
                ],
              ),
            padding: EdgeInsets.only(left:
            40),
            width:900 ,
            child: Form(
              key: _form,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: LocaleKeys.Scientific_Name.tr(),labelStyle: TextStyle(fontSize: 21)),
                    textInputAction: TextInputAction.next,
                    focusNode:Scientific_Name_Node,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(Commercial_Name_Node);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LocaleKeys.Please_provide_a_value.tr();
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) {
                        newMedicine = Medicine(
                          scientificName: value.toString(),
                          commercialName: newMedicine.commercialName,
                          id: newMedicine.id,
                          category: newMedicine.category,
                          manufacturer: newMedicine.manufacturer,
                          quantityAvailable: newMedicine.quantityAvailable,
                          expiryDate: newMedicine.expiryDate,
                          price: newMedicine.price,
                          imageUrl: newMedicine.imageUrl,
                          isfavorate: newMedicine.isfavorate,

                        );
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: LocaleKeys.Commercial_Name.tr(),labelStyle: TextStyle(fontSize: 21)),
                    initialValue: _initValues['commercialName'].toString(),
                    textInputAction: TextInputAction.next,
                    focusNode: Commercial_Name_Node,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(Category_Node);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LocaleKeys.Please_provide_a_value.tr();
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) {
                        newMedicine = Medicine(
                          scientificName: newMedicine.scientificName,
                          commercialName: value.toString(),
                          id: newMedicine.id,
                          category: newMedicine.category,
                          manufacturer: newMedicine.manufacturer,
                          quantityAvailable: newMedicine.quantityAvailable,
                          expiryDate: newMedicine.expiryDate,
                          price: newMedicine.price,
                          imageUrl: newMedicine.imageUrl,
                          isfavorate: newMedicine.isfavorate,

                        );
                      }
                    },
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: LocaleKeys.Category.tr(),
                      labelStyle: TextStyle(fontSize: 21),
                    ),
                    value: selectedCategory ?? categoryMap.keys.first,
                    items: categoryMap.keys.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (String? selectedCategory) {
                      if (selectedCategory != null) {
                        int categoryValue = categoryMap[selectedCategory] ?? 0;

                        // Update the state or perform any actions with the selected category
                        setState(() {
                          // Update the form state or other variables as needed
                        });
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return LocaleKeys.Please_provide_a_value.tr();
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) {
                        int categoryValue = categoryMap[value] ?? 0;

                        newMedicine = Medicine(
                          scientificName: newMedicine.scientificName,
                          commercialName: newMedicine.commercialName,
                          id: newMedicine.id,
                          category: categoryValue,
                          manufacturer: newMedicine.manufacturer,
                          quantityAvailable: newMedicine.quantityAvailable,
                          expiryDate: newMedicine.expiryDate,
                          price: newMedicine.price,
                          imageUrl: newMedicine.imageUrl,
                          isfavorate: newMedicine.isfavorate,
                        );
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: LocaleKeys.Manufacturer.tr(),labelStyle: TextStyle(fontSize: 21)),
                    initialValue: _initValues['manufacturer'].toString(),
                    textInputAction: TextInputAction.next,
                    focusNode: Manufacturer_Node,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context)
                          .requestFocus(Quantity_Available_Node);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LocaleKeys.Please_provide_a_value.tr();
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) {
                        newMedicine = Medicine(
                          scientificName: newMedicine.scientificName,
                          commercialName: newMedicine.commercialName,
                          id: newMedicine.id,
                          category: newMedicine.category,
                          manufacturer: value.toString(),
                          quantityAvailable: newMedicine.quantityAvailable,
                          expiryDate: newMedicine.expiryDate,
                          price: newMedicine.price,
                          imageUrl: newMedicine.imageUrl,
                          isfavorate: newMedicine.isfavorate,

                        );
                      }
                    },
                  ),
                  TextFormField(
                    decoration:
                    InputDecoration(labelText: LocaleKeys.Quantity.tr(),labelStyle: TextStyle(fontSize: 21)),
                    initialValue: _initValues['quantityAvailable'].toString(),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    focusNode: Quantity_Available_Node,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(Expiry_Date_Node);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LocaleKeys.Please_provide_a_value.tr();
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) {
                        newMedicine = Medicine(
                          scientificName: newMedicine.scientificName,
                          commercialName: newMedicine.commercialName,
                          id: newMedicine.id,
                          category: newMedicine.category,
                          manufacturer: newMedicine.manufacturer,
                          quantityAvailable: double.parse(value).toDouble(),
                          expiryDate: newMedicine.expiryDate,
                          price: newMedicine.price,
                          imageUrl: newMedicine.imageUrl,
                          isfavorate: newMedicine.isfavorate,

                        );
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: LocaleKeys.Expiry_Date.tr(),labelStyle: TextStyle(fontSize: 21)),
                    initialValue: _initValues['expiryDate'].toString(),
                    textInputAction: TextInputAction.next,
                    focusNode: Expiry_Date_Node,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(Price_Name_Node);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LocaleKeys.Please_provide_a_value.tr();
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) {
                        newMedicine = Medicine(
                          scientificName: newMedicine.scientificName,
                          commercialName: newMedicine.commercialName,
                          id: newMedicine.id,
                          category: newMedicine.category,
                          manufacturer: newMedicine.manufacturer,
                          quantityAvailable: newMedicine.quantityAvailable,
                          expiryDate:(value).toString(),
                          price: newMedicine.price,
                          imageUrl: newMedicine.imageUrl,
                          isfavorate: newMedicine.isfavorate,

                        );
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: LocaleKeys.Price.tr(),labelStyle: TextStyle(fontSize: 21)),
                    initialValue: _initValues['price'].toString(),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    focusNode: Price_Name_Node,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(Img_Node);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LocaleKeys.Please_provide_a_value.tr();
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) {
                        newMedicine = Medicine(
                          scientificName: newMedicine.scientificName,
                          commercialName: newMedicine.commercialName,
                          id: newMedicine.id,
                          category: newMedicine.category,
                          manufacturer: newMedicine.manufacturer,
                          quantityAvailable: newMedicine.quantityAvailable,
                          expiryDate: newMedicine.expiryDate,
                          price: double.parse(value).toDouble(),
                          imageUrl: newMedicine.imageUrl,
                          isfavorate: newMedicine.isfavorate,

                        );
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: LocaleKeys.Img_URL.tr(),labelStyle: TextStyle(fontSize: 21)),
                    initialValue: _initValues['imageUrl'].toString(),
                    keyboardType: TextInputType.url,
                    focusNode: Img_Node,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) {
                      _saveForm();
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LocaleKeys.Please_provide_a_value.tr();
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) {
                        newMedicine = Medicine(
                          scientificName: newMedicine.scientificName,
                          commercialName: newMedicine.commercialName,
                          id: newMedicine.id,
                          category: newMedicine.category,
                          manufacturer: newMedicine.manufacturer,
                          quantityAvailable: newMedicine.quantityAvailable,
                          expiryDate: newMedicine.expiryDate,
                          price: newMedicine.price,
                          imageUrl: value.toString(),
                          isfavorate: newMedicine.isfavorate,
                        );
                      }
                    },
                  ),
                  SizedBox(height: 70),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ElevatedButton(

                        onPressed: () {
                          _saveForm();
                        },

                        child: Text(LocaleKeys.Save.tr(),style: TextStyle(fontSize: 20,color: Colors.white),),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(130, 40), // Set the width and height
                          primary: Colors.pink, // Set the background color
                          // You can also customize other properties like padding, elevation, etc.
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed(ProductsScreen.routeName);

                        },
                        child: Text(LocaleKeys.Cancel.tr(),style: TextStyle(fontSize: 20,color: Colors.white),),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(130, 40), // Set the width and height
                          primary: Colors.yellow, // Set the background color
                          // You can also customize other properties like padding, elevation, etc.
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

          ],
      ),

    ],
      ),
      ),
        ]),
    ),
              Column(
                children: [
                  SizedBox(height: 400,),
                  Image.asset("assets/images/Screenshot 2023-11-22 142150.png"),
                ],
              )
    ]),
    );
  }
}
