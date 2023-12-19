import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine_warehouse/warehouse_owner_screens/web_auth_screen.dart';

class StartPage extends StatelessWidget{
  var IsWarehouseOwner =false;
  var Ispharmasist  = false;
  static const routeName = '/StartPage';

  @override

    Widget build(BuildContext context) {

    return Scaffold(
      body: Row(
        children: [
          // Left side with text
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to the Medical Warehouse',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Your trusted source for medical supplies.',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 100),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(WebAuthScreen.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(130, 40), // Set the width and height
                      primary: Colors.deepPurpleAccent, ),
                    child: Text('Get Started'),
                  ),
                ],
              ),
            ),
          ),

          // Right side with image
          Expanded(
            flex: 3,
            child: Container(
              height: 1200,
              width: 1200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Screenshot 2023-12-12 035745.jpg',), // replace with your image path

                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}