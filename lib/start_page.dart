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
      body: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage('assets/images/pharmeasy.png'), // replace with your image path
    fit: BoxFit.contain,
    ),
    ),
    child: Row(
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

                  SizedBox(height: 400,width: 200,),
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

        ],
      ),
      ),
    );
  }
}