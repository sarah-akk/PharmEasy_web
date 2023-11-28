import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine_warehouse/models/medicine.dart';
import 'package:provider/provider.dart';

import '../models/medicines.dart';
import '../warehouse_owner_widgets/Web_medicine_gride.dart';
import '../warehouse_owner_widgets/add_medicine.dart';
import '../warehouse_owner_widgets/web_drawer.dart';


enum FilterOptions {
  Favorites,
  All,
}

class MedicinesOverviewScreen extends StatefulWidget {
  static const routeName = '/MedicinesOverviewScreen';

  @override
  _MedicinesOverviewScreenState createState() => _MedicinesOverviewScreenState();
}

class _MedicinesOverviewScreenState extends State<MedicinesOverviewScreen> {
  var _showOnlyFavorites = false;
  var is_init=true;
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  @override
  void initState(){
    super.initState();
  }

  @override
  void didChangeDependencies(){
    if(is_init){
      // Provider.of<MedicinesList>(context).fetchAndSetProducts();
    }
    is_init=false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0), // Set your preferred height
    child:
           AppBar(

           title:  Stack(
              children: <Widget>[

                // Outline Text// Set the text color
                Text('OnLine pharmacy Store',textAlign:TextAlign.end,style: TextStyle(
                  fontSize: 40,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 4
                    ..color = Colors.black54,),
                ),
                Text('OnLine pharmacy Store', textAlign:TextAlign.end, style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),

              ],

            ),

          flexibleSpace: Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.lightBlueAccent, Colors.tealAccent],
              ),
            ),

          ),

        ),
        ),
      drawer: WebDrawer(),
      body:  Stack(
        fit: StackFit.expand,
        children: [
        // Background Image
        Image.asset(
        'assets/images/amai3.png', // Replace with your image path
        fit: BoxFit.cover,
      ),
      SingleChildScrollView(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
        SizedBox(height: 50),
         Row(
          children: <Widget> [
            Container(
              padding: EdgeInsets.only(left: 200),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.pinkAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  elevation: 5, // Adjust the elevation as needed
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(MedicineAddScreen.routeName);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.add_circle,
                      size: 30,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Add New Medicine",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 20,),
            Container(
              color: Colors.white,
              alignment: Alignment.bottomCenter,
                height: 50.0, // Set the height as needed
                width: 900.0, //
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search for medicines ...',
                    border: OutlineInputBorder(  // Customize the border
                      borderRadius: BorderRadius.circular(10.0),  // Adjust the border radius as needed
                      borderSide: BorderSide(  // Adjust the border color, width, and style as needed
                        color: Colors.greenAccent,
                        width: 2.0,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),
            Container(
              decoration: BoxDecoration(color: Colors.yellowAccent,borderRadius: BorderRadius.circular(20)),
              child: IconButton(
                icon: Icon(Icons.search,color: Colors.black,),
                onPressed: () {
                  // Perform search using _searchQuery
                  // You can implement your search logic here
                  print('Searching for: $_searchQuery');
                },

              ),
            ),
          ],
        ),
    SizedBox(height: 50),
      Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'Available Medicines',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),

      SizedBox(height: 30),

        SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 30,top: 30),
          width: 1300,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black, // Border color
              width: 0.5,           // Border width
              style: BorderStyle.solid, // Border style (solid, dashed, or none)
            ),
            color: Colors.white60,
            borderRadius: BorderRadius.circular(10.0), // Border radius
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>[

             SizedBox(
               height: 1500,
                 child: WebMedicineGride()),
            ],
          ),
        ),
    ),
         ],
    ),
    ),
      ],
      ),
    )

    ;

  }
}
