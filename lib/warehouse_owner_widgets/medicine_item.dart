import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/medicine.dart';
import 'Item_Details.dart';


class WebMedicineItem extends StatelessWidget {

  final Medicine med;
  WebMedicineItem(this.med);

  // final String id;
  @override
  Widget build(BuildContext context) {
    final medicine = Provider.of<Medicine>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),

      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
                MedicineDetailsCard.routeName,
                arguments: med.id);
          },
          child: Image.network(
            med.imageUrl,
            fit: BoxFit.contain,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.blueAccent,
          title: Text(
            med.commercialName,
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
