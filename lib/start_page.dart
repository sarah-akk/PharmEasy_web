import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine_warehouse/warehouse_owner_screens/web_auth_screen.dart';

class StartPage extends StatelessWidget{
  var IsWarehouseOwner =false;
  var Ispharmasist  = false;

  @override

    Widget build(BuildContext context) {

    // this page where the application Starts

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome !',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold,color: Colors.purple),
            ),
            Image.asset('assets/images/185025829-3d-icon-with-pharmacy-3d-on-transparent-background-for-web-design-pharmacy-concept-3d-realistic.jpg'
              ,height: 300,width: 300,),
            SizedBox(height: 20),
            Text(
              'who are you ?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.blueGrey),
            ),
            SizedBox(height: 20), // Adding space between text and buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                ElevatedButton(
                  style:ElevatedButton.styleFrom(
                      primary: Colors.lightBlueAccent,
                      shadowColor: Colors.black54
                  ),
                  onPressed: () {
                    // Add functionality for the first button
                    Navigator.of(context).pushNamed(WebAuthScreen.routeName);
                  },
                  child: Text('Warehouse Owner'),
                ),
                SizedBox(width: 50), // Adding some space between the buttons
                ElevatedButton(
                  style:ElevatedButton.styleFrom(
                      primary: Colors.lightBlueAccent,
                      shadowColor: Colors.black54

                  ),
                  onPressed: () {
                    // Add functionality for the second button

                  },
                  child: Text('Pharmasist'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


}