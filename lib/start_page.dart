import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine_warehouse/warehouse_owner_screens/web_auth_screen.dart';

class StartPage extends StatelessWidget{
  var IsWarehouseOwner =false;
  var Ispharmasist  = false;

  @override

    Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
        Image.asset("assets/images/blue-flow-purple-gray-wavy-260nw-2148489969.png",
        fit: BoxFit.cover,),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome !',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold,color: Colors.lightBlueAccent),
            ),
            Image.asset('assets/images/185025829-3d-icon-with-pharmacy-3d-on-transparent-background-for-web-design-pharmacy-concept-3d-realistic.jpg'
              ,height: 300,width: 300,),
            SizedBox(height: 20),
            SizedBox(height: 20), // Adding space between text and buttons

                ElevatedButton(
                  style:ElevatedButton.styleFrom(
                      primary: Colors.lightBlueAccent,
                      shadowColor: Colors.black54
                  ),
                  onPressed: () {
                    // Add functionality for the first button
                    Navigator.of(context).pushNamed(WebAuthScreen.routeName);
                  },
                  child: Text('login'),
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