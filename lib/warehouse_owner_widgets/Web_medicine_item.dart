import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/Auth.dart';
import '../models/medicine.dart';
import 'Web_Item_Details.dart';


class WebMedicineItem extends StatefulWidget {


  @override
  State<WebMedicineItem> createState() => _WebMedicineItemState();
}

class _WebMedicineItemState extends State<WebMedicineItem> {
  // final String id;
  @override
  Widget build(BuildContext context) {
    final medicine = Provider.of<Medicine>(context, listen: false);
   //  final cart = Provider.of<Cart>(context, listen: false);
   //  final authData =Provider.of<Auth>(context,listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),

      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
                MedicineDetailsCard.routeName,
                arguments: medicine.id);
          },
          child: Image.network(
            medicine.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
            medicine.commercialName,
            textAlign: TextAlign.center,


          ),
    leading:  IconButton(
    icon: Icon(
     Icons.edit,
    ),
    color: Colors.pinkAccent,
    onPressed: () {

    },
    ),
    trailing: IconButton(
    icon: Icon(
    Icons.delete,
    color: Colors.pinkAccent,
    ),
    onPressed: () {

    },
    ),

          ),
        ),

    );
  }
}
