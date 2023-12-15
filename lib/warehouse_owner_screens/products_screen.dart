import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../warehouse_owner_widgets/medicine_gride.dart';
import '../warehouse_owner_widgets/drawer.dart';
import 'add_medicine.dart';
import '../warehouse_owner_widgets/page_header.dart';
import '../warehouse_owner_widgets/top_bar.dart';

class ProductsScreen extends StatefulWidget {
  static const routeName = '/ProductsScreen';

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  var _showOnlyFavorites = false;
  var isInit = true;
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void didChangeDependencies() {
    if (isInit) {
      // Provider.of<MedicinesList>(context).fetchAndSetProducts();
    }
    isInit = false;

    super.didChangeDependencies();
  }
  PopupMenuItem<String> buildPopupMenuItem(String category) {
    return PopupMenuItem<String>(
      value: category,
      child: Text(category),
    );
  }

  PopupMenuItem<String> buildAllCategoriesMenuItem() {
    return PopupMenuItem<String>(
      value: 'All',
      child: Text('All Categories'),
    );
  }

  PopupMenuButton<String> buildCategoryFilterButton() {
    return PopupMenuButton<String>(
      icon: Icon(Icons.filter_list),
      onSelected: (String selectedCategory) {
        // Handle category selection
        setState(() {
          // Update your filtering logic here
          _searchQuery = selectedCategory;
        });
      },
      itemBuilder: (BuildContext context) {
        return [
          buildAllCategoriesMenuItem(),
          buildPopupMenuItem('Neurological medications'),
          buildPopupMenuItem('Heart medications'),
          buildPopupMenuItem('Anti-inflammatories'),
          buildPopupMenuItem('Food supplements'),
          buildPopupMenuItem('Painkillers'),
        ];
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          mydrawer(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  TopBar(),
                  PageHeader(text: "medicines"),
                  SizedBox(height: 50),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 100),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.pinkAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            elevation: 5,
                          ),
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed(
                                MedicineAddScreen.routeName);
                          },
                          child: Tooltip(
                            message: 'Add a new medicine',
                          child: Row(
                            children: [
                              Icon(
                                Icons.add_circle,
                                size: 45,
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
                      ),
                      SizedBox(width: 20),
                      Container(
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
                        alignment: Alignment.bottomCenter,
                        height: 50.0,
                        width: 900.0,
                        child: TypeAheadFormField(
                          textFieldConfiguration: TextFieldConfiguration(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search for medicines / categories ...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.greenAccent,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                          suggestionsCallback: (pattern) async {
                            return [
                              'Neurological medications',
                              'Heart medications',
                              'Anti-inflammatories',
                              'Food supplements',
                              'Painkillers',
                            ].where((category) =>
                                category.toLowerCase().contains(pattern.toLowerCase()));
                          },
                          itemBuilder: (context, suggestion) {
                            return ListTile(
                              title: Text(suggestion),
                            );
                          },
                          onSuggestionSelected: (suggestion) {
                            // Handle the selection of a suggestion
                            setState(() {
                              _searchQuery = suggestion;
                            });
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(20)),
                        child: IconButton(
                          icon: Icon(Icons.search, color: Colors.black),
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
                      padding: EdgeInsets.only(left: 30, top: 30),
                      width: 1300,
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

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children:<Widget> [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.lightBlueAccent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'choose category : ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              buildCategoryFilterButton(),
                            ],
                          ),
                          SizedBox(
                            height: 1500,
                            child: WebMedicineGride(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
