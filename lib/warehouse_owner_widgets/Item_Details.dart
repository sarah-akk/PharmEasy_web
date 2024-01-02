import 'package:flutter/material.dart';
import 'package:medicine_warehouse/Lang/Locale_keys_.g.dart';
import 'package:medicine_warehouse/models/medicines.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../models/medicine.dart';

class MedicineDetailsCard extends StatelessWidget {
  static const routeName = '/MedicineDetailsCard';

  @override
  Widget build(BuildContext context) {

    final medicineId = ModalRoute.of(context)!.settings.arguments as int;

    final loadedMedicine = Provider.of<MedicinesList>(
      context,
      listen: false,
    ).findById(medicineId);


    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context, loadedMedicine),
    );
  }

  Widget contentBox(BuildContext context, Medicine loadedMedicine) {

    String category;
    if(loadedMedicine.category==1)
      category='Neurological medication';
    else if (loadedMedicine.category==2)
      category='Heart medications';
    else if(loadedMedicine.category==3)
      category='Anti-inflammatories';
    else if(loadedMedicine.category==4)
      category='Food supplements';
    else
      category='Painkillers';


    return Container(
      height: 650,
      width: 500,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0, 10),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(
            loadedMedicine.imageUrl,
            height: 200, // Adjust the height as needed
            width: 200, // Adjust the width as needed
          ),
          SizedBox(height: 30,),
          Text('${LocaleKeys.Scientific_Name.tr()} : ${loadedMedicine.scientificName}',
            style: TextStyle(fontWeight: FontWeight.bold , fontSize: 22)),
          SizedBox(height: 8),
          Text('${LocaleKeys.Commercial_Name.tr()} : ${loadedMedicine.commercialName}',style: TextStyle(fontSize: 18)),
          SizedBox(height: 8),
          Text('${LocaleKeys.Category.tr()} : ${category}', style: TextStyle(fontSize: 18)),
          SizedBox(height: 8),
          Text('${LocaleKeys.Manufacturer.tr()} : ${loadedMedicine.manufacturer}',style: TextStyle(fontSize: 18)),
          SizedBox(height: 8),
          Text('${LocaleKeys.Quantity.tr()} : ${loadedMedicine.quantityAvailable.toString()}',style: TextStyle(fontSize: 18)),
          SizedBox(height: 8),
          Text('${LocaleKeys.Expiry_Date.tr()} : ${loadedMedicine.expiryDate.toString()}',style: TextStyle(fontSize: 18)),
          SizedBox(height: 8),
          Text('${LocaleKeys.Price.tr()} : ${loadedMedicine.price.toString()}',style: TextStyle(fontSize: 18)),
          SizedBox(height: 30,),

          ElevatedButton(

            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },

            child: Text('${LocaleKeys.Close.tr()}',style: TextStyle(color: Colors.white),),
            style: ElevatedButton.styleFrom(
              primary: Colors.pink, // Set the background color
              // You can also customize other properties like padding, elevation, etc.
            ),

          ),
        ],
      ),
    );
  }
}
