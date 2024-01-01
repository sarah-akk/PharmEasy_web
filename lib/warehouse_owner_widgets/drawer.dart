import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medicine_warehouse/Lang/locale_keys.g.dart';

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
               Text('PharmEasy',textAlign:TextAlign.start,style: TextStyle(
                 fontSize: 28 ,
                 foreground: Paint()
                   ..style = PaintingStyle.stroke
                   ..strokeWidth = 4
                   ..color = Colors.black54,),
               ),
               Text('PharmEasy', textAlign:TextAlign.start, style: TextStyle(
                 fontSize: 28,
                 color: Colors.white,
               ),
               ),
             ],
           ),
         ),
         SizedBox(height: 20,),
        // Image.asset("assets/images/Screenshot 2023-11-20 163429.png"),
         ListTile(
           leading: Icon(Icons.dashboard, color: Colors.white),
           title: Text(LocaleKeys.dashboard.tr(), style: TextStyle(color: Colors.white,fontSize: 20)),
           onTap: () {
             Navigator.of(context).pushReplacementNamed('/HomePageDesktop')      ;
           },
         ),
         ListTile(
           leading: Icon(Icons.shopping_cart, color: Colors.white),
           title: Text(LocaleKeys.Orders.tr(), style: TextStyle(color: Colors.white,fontSize: 20)),
           onTap: () {
             Navigator.of(context).pushReplacementNamed('/OrdersScreen')      ;
           },
         ),
         ListTile(
           leading: Icon(Icons.medical_information, color: Colors.white),
           title: Text(LocaleKeys.Products.tr(), style: TextStyle(color: Colors.white,fontSize: 20)),
           onTap: () {
             Navigator.of(context).pushReplacementNamed('/ProductsScreen');
           },
         ),
         ListTile(
           leading: Icon(Icons.logout, color: Colors.white),
           title: Text(LocaleKeys.log_out.tr(), style: TextStyle(color: Colors.white,fontSize: 20)),
           onTap: () {
             Navigator.of(context).pushReplacementNamed('/StartPage');
           },
         ),
         // Add more options as needed
       ],
     ),
   );
  }
}
