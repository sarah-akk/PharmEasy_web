import 'package:flutter/material.dart';

class mydrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
   return  Container(
     width: 240,
     color: Colors.indigo, // Customize the color as needed
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Padding(
           padding: const EdgeInsets.all(15.0),
           child: Stack(
             children: <Widget>[
               Text('OnLine pharmacy Store',textAlign:TextAlign.start,style: TextStyle(
                 fontSize: 25,
                 foreground: Paint()
                   ..style = PaintingStyle.stroke
                   ..strokeWidth = 4
                   ..color = Colors.black54,),
               ),
               Text('OnLine pharmacy Store', textAlign:TextAlign.start, style: TextStyle(
                 fontSize: 25,
                 color: Colors.white,
               ),
               ),
             ],
           ),
         ),
         SizedBox(height: 20,),
         ListTile(
           leading: Icon(Icons.dashboard, color: Colors.white),
           title: Text('Dashboard', style: TextStyle(color: Colors.white,fontSize: 20)),
           onTap: () {
             Navigator.of(context).pushReplacementNamed('/HomePageDesktop')      ;
           },
         ),
         ListTile(
           leading: Icon(Icons.shopping_cart, color: Colors.white),
           title: Text('Orders', style: TextStyle(color: Colors.white,fontSize: 20)),
           onTap: () {
             //Navigator.of(context).pushReplacementNamed('/HomePageDesktop')      ;
           },
         ),
         ListTile(
           leading: Icon(Icons.widgets, color: Colors.white),
           title: Text('Products', style: TextStyle(color: Colors.white,fontSize: 20)),
           onTap: () {
             Navigator.of(context).pushReplacementNamed('/ProductsScreen');
           },
         ),
         // Add more options as needed
       ],
     ),
   );
  }
}
