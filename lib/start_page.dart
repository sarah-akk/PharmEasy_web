import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine_warehouse/warehouse_owner_screens/web_auth_screen.dart';

class StartPage extends StatelessWidget {
  var IsWarehouseOwner = false;
  var Ispharmasist = false;
  static const routeName = '/StartPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/pharmeasy.png'),
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
                    SizedBox(
                      height: 400,
                      width: 200,
                    ),
                    Container(
                      width: 130,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.deepPurpleAccent, Colors.blueAccent],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(WebAuthScreen.routeName);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          elevation: 0, // Remove the button's default elevation
                        ),
                        child: Text('Get Started',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 19),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
