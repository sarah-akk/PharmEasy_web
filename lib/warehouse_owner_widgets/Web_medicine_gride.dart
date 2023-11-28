import 'package:flutter/cupertino.dart';
import 'package:medicine_warehouse/models/medicine.dart';
import 'package:medicine_warehouse/models/medicines.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';

import 'Web_medicine_item.dart';

class WebMedicineGride extends StatelessWidget{

  @override
    Widget build(BuildContext context) {
    final productsData = Provider.of<MedicinesList>(context);
    final med =  productsData.items;

      return GridView.builder(

        padding: const EdgeInsets.all(10.0),
        itemCount: med.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          // builder: (c) => products[i],
          value: med[i],
          child: WebMedicineItem(
          ),
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          childAspectRatio: 3/2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20 ,
        ),
      );
    }
  }
