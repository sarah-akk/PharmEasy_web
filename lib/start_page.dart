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
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
        Image.asset("assets/images/cute-pink-blue-abstract-background-for-web-design-vector-22334520.jpg",
        fit: BoxFit.cover,),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome !',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold,color: Colors.pinkAccent),
            ),
            SizedBox(height: 30),

            Container(
            height: 300,width: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius:BorderRadius.circular(50),
              ),
              child: Image.asset('assets/images/185025829-3d-icon-with-pharmacy-3d-on-transparent-background-for-web-design-pharmacy-concept-3d-realistic.jpg'
             ,fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 50),

                ElevatedButton(
                  style:ElevatedButton.styleFrom(
                      primary: Colors.deepPurpleAccent,
                      shadowColor: Colors.black54,
                  fixedSize: Size(130, 40),
                    // Set the width and height
                  // You can also customize other properties like padding, elevation, etc
                  ),
                  onPressed: () {
                    // Add functionality for the first button
                    Navigator.of(context).pushNamed(WebAuthScreen.routeName);
                  },
                  child: Text('Start now',style: TextStyle(fontSize: 20),),
                ),
                SizedBox(width: 50), // Adding some space between the buttons
            
          ],
        ),
      ),
    ],
      ),
    );
  }


}