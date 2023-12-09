import 'package:flutter/material.dart';
import 'package:medicine_warehouse/models/medicine.dart';
import 'package:medicine_warehouse/models/medicines.dart';
import 'package:medicine_warehouse/warehouse_owner_widgets/medicine_gride.dart';
import 'package:medicine_warehouse/warehouse_owner_widgets/page_header.dart';
import 'package:medicine_warehouse/warehouse_owner_widgets/top_bar.dart';
import 'package:provider/provider.dart';
import '../warehouse_owner_screens/products_screen.dart';
import 'drawer.dart';
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

  var newMedicine = Medicine(
    id: null,
    scientificName: '',
    commercialName: '',
    category: '',
    manufacturer: '',
    quantityAvailable: 0,
    expiryDate: DateTime.now(),
    price: 0,
    imageUrl: '',
  );

  var _initValues = {
    'scientificName': '',
    'commercialName': '',
    'Category': '',
    'manufacturer': '',
    'quantityAvailable': 0,
    'expiryDate': DateTime.now(),
    'price': 0,
    'imageUrl': '',
  };

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
            PageHeader(text: "Add medicine"),
            SizedBox(height: 50,),
            SingleChildScrollView(
            child: Container(
            decoration: BoxDecoration(color: Colors.white70),
            padding: EdgeInsets.only(left: 100),
            width:800 ,
            child: Form(
              key: _form,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Scientific Name',labelStyle: TextStyle(fontSize: 21)),
                    textInputAction: TextInputAction.next,
                    focusNode:Scientific_Name_Node,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(Commercial_Name_Node);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please provide a value.';
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
                        );
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Commercial Name',labelStyle: TextStyle(fontSize: 21)),
                    initialValue: _initValues['commercialName'].toString(),
                    textInputAction: TextInputAction.next,
                    focusNode: Commercial_Name_Node,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(Category_Node);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please provide a value.';
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
                        );
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Category',labelStyle: TextStyle(fontSize: 21)),
                    initialValue: _initValues['Category'].toString(),
                    textInputAction: TextInputAction.next,
                    focusNode: Category_Node,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(Manufacturer_Node);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please provide a value.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) {
                        newMedicine = Medicine(
                          scientificName: newMedicine.scientificName,
                          commercialName: newMedicine.commercialName,
                          id: newMedicine.id,
                          category: value.toString(),
                          manufacturer: newMedicine.manufacturer,
                          quantityAvailable: newMedicine.quantityAvailable,
                          expiryDate: newMedicine.expiryDate,
                          price: newMedicine.price,
                          imageUrl: newMedicine.imageUrl,
                        );
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Manufacturer',labelStyle: TextStyle(fontSize: 21)),
                    initialValue: _initValues['manufacturer'].toString(),
                    textInputAction: TextInputAction.next,
                    focusNode: Manufacturer_Node,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context)
                          .requestFocus(Quantity_Available_Node);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please provide a value.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) {
                        newMedicine = Medicine(
                          scientificName: newMedicine.scientificName,
                          commercialName: newMedicine.commercialName,
                          id: newMedicine.id,
                          category: newMedicine.manufacturer,
                          manufacturer: value.toString(),
                          quantityAvailable: newMedicine.quantityAvailable,
                          expiryDate: newMedicine.expiryDate,
                          price: newMedicine.price,
                          imageUrl: newMedicine.imageUrl,
                        );
                      }
                    },
                  ),
                  TextFormField(
                    decoration:
                    InputDecoration(labelText: 'Quantity Available',labelStyle: TextStyle(fontSize: 21)),
                    initialValue: _initValues['quantityAvailable'].toString(),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    focusNode: Quantity_Available_Node,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(Expiry_Date_Node);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please provide a value.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) {
                        newMedicine = Medicine(
                          scientificName: newMedicine.scientificName,
                          commercialName: newMedicine.commercialName,
                          id: newMedicine.id,
                          category: newMedicine.manufacturer,
                          manufacturer: newMedicine.manufacturer,
                          quantityAvailable: int.parse(value).toInt(),
                          expiryDate: newMedicine.expiryDate,
                          price: newMedicine.price,
                          imageUrl: newMedicine.imageUrl,
                        );
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Expiry Date',labelStyle: TextStyle(fontSize: 21)),
                    initialValue: _initValues['expiryDate'].toString(),
                    textInputAction: TextInputAction.next,
                    focusNode: Expiry_Date_Node,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(Price_Name_Node);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please provide a value.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) {
                        newMedicine = Medicine(
                          scientificName: newMedicine.scientificName,
                          commercialName: newMedicine.commercialName,
                          id: newMedicine.id,
                          category: newMedicine.manufacturer,
                          manufacturer: newMedicine.manufacturer,
                          quantityAvailable: newMedicine.quantityAvailable,
                          expiryDate: DateTime.parse(value),
                          price: newMedicine.price,
                          imageUrl: newMedicine.imageUrl,
                        );
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Price Name',labelStyle: TextStyle(fontSize: 21)),
                    initialValue: _initValues['price'].toString(),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    focusNode: Price_Name_Node,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(Img_Node);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please provide a value.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) {
                        newMedicine = Medicine(
                          scientificName: newMedicine.scientificName,
                          commercialName: newMedicine.commercialName,
                          id: newMedicine.id,
                          category: newMedicine.manufacturer,
                          manufacturer: newMedicine.manufacturer,
                          quantityAvailable: newMedicine.quantityAvailable,
                          expiryDate: newMedicine.expiryDate,
                          price: double.parse(value).toDouble(),
                          imageUrl: newMedicine.imageUrl,
                        );
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Img URL',labelStyle: TextStyle(fontSize: 21)),
                    initialValue: _initValues['imageUrl'].toString(),
                    keyboardType: TextInputType.url,
                    focusNode: Img_Node,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) {
                      _saveForm();
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please provide a value.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) {
                        newMedicine = Medicine(
                          scientificName: newMedicine.scientificName,
                          commercialName: newMedicine.commercialName,
                          id: newMedicine.id,
                          category: newMedicine.manufacturer,
                          manufacturer: newMedicine.manufacturer,
                          quantityAvailable: newMedicine.quantityAvailable,
                          expiryDate: newMedicine.expiryDate,
                          price: newMedicine.price,
                          imageUrl: value.toString(),
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
                          // Add your logic for saving the changes
                          _saveForm();

                        },

                        child: Text('Save',style: TextStyle(fontSize: 20),),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(130, 40), // Set the width and height
                          primary: Colors.pink, // Set the background color
                          // You can also customize other properties like padding, elevation, etc.
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed(ProductsScreen.routeName);

                          // Add your logic for discarding changes or canceling
                        },
                        child: Text('Cancel',style: TextStyle(fontSize: 20),),
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
    ]),
    );
  }
}
