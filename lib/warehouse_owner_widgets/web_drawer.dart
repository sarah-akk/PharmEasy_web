import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Auth.dart';
import '../warehouse_owner_screens/web_overview_screen.dart';

class WebDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(

            title:  Stack(
          children: <Widget>[
          // Outline Text// Set the text color
          Text('settings',textAlign:TextAlign.end,style: TextStyle(
            fontSize: 30,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 2
              ..color = Colors.black54,),
          ),
          Text('settings', textAlign:TextAlign.end, style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),),],
      ),
            flexibleSpace: Container(
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.purpleAccent, Colors.pinkAccent],
                ),
              ),
            ),
            automaticallyImplyLeading: false,
          ),
          Image.asset("assets/images/Screenshot 2023-11-20 163429.png",width: 300,height: 300,),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Browse / Edite Medicines'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(MedicinesOverviewScreen.routeName);
            },
          ),

          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Browse / Edit Orders'),
            onTap: () {
              print("");


            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              print("");

            },
          ),
        ],
      ),
    );
  }
}
