import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine_warehouse/models/medicine.dart';
import 'package:medicine_warehouse/models/medicines.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';

import 'medicine_item.dart';

class WebMedicineGride extends StatefulWidget{
  @override
  State<WebMedicineGride> createState() => _WebMedicineGrideState();
}

class _WebMedicineGrideState extends State<WebMedicineGride> {

  @override
  void initState() {
    super.initState();
    refrechProducts(context);
  }

  Future<void> refrechProducts(BuildContext context)async{

    await  Provider.of<MedicinesList>(context,listen: false).fetchAndSetMedicines(true);
  }

  @override
  Widget build(BuildContext context) {

    final productsData = Provider.of<MedicinesList>(context);

    return RefreshIndicator(
      onRefresh: () => refrechProducts(context),
      child: productsData.items.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Consumer<MedicinesList>(
        builder: (ctx, productsData, _) => GridView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: productsData.items.length,
          itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
            value: productsData.items[i],
            child: WebMedicineItem(
              productsData.items[i],
            ),
          ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              childAspectRatio: 3/2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20 ,
            ),
          ),
        ),
      );
  }
}
