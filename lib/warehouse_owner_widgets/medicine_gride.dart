import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine_warehouse/models/medicine.dart';
import 'package:medicine_warehouse/models/medicines.dart';
import 'package:provider/provider.dart';

import '../Lang/locale_keys.g.dart';
import 'medicine_item.dart';

class WebMedicineGride extends StatefulWidget {

  String SearchQuery;
  String searchQuery;
  WebMedicineGride(this.searchQuery, this.SearchQuery);

  @override
  State<WebMedicineGride> createState() => _WebMedicineGrideState();
}

class _WebMedicineGrideState extends State<WebMedicineGride> {

  late int categoryNumber=0;

  @override
  void initState() {
    super.initState();
    refrechCategoryProducts(context);
  }

  Future<void> refrechCategoryProducts(BuildContext context)async{

    await  Provider.of<MedicinesList>(context,listen: false).fetchMedicines(categoryNumber);
  }

  Future<void> getsearch(BuildContext context, String searchQuery) async {
    await Provider.of<MedicinesList>(context, listen: false)
        .getSearch(searchQuery);
  }


  @override
  Widget build(BuildContext context) {

    final productsData = Provider.of<MedicinesList>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                LocaleKeys.choose_category.tr(),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 20,),
            DropdownButton<int>(
              value: categoryNumber,
              items: [
                DropdownMenuItem(value: 0, child: Text(LocaleKeys.All.tr())),
                DropdownMenuItem(value: 1, child: Text(LocaleKeys.Heart_medications.tr())),
                DropdownMenuItem(value: 2, child: Text(LocaleKeys.Neurological_medications.tr())),
                DropdownMenuItem(value: 3, child: Text(LocaleKeys.Anti_inflammatories.tr())),
                DropdownMenuItem(value: 4, child: Text(LocaleKeys.Food_supplements.tr())),
                DropdownMenuItem(value: 5, child: Text(LocaleKeys.Painkillers.tr())),
              ],
              onChanged: (value) {
                setState(() {
                  categoryNumber = value!;
                  refrechCategoryProducts(context);
                });
              },
            ),
          ],
        ),
SizedBox(height: 40,),
        Expanded(
          child: RefreshIndicator(
            onRefresh: ()   {
              // Call the appropriate method based on the presence of a search query
              if (widget.SearchQuery.isEmpty) {
                return refrechCategoryProducts(context);
              } else {
                widget.SearchQuery='';
                return getsearch(context,widget.SearchQuery);
              }
            },
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
                  crossAxisCount: 6,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}