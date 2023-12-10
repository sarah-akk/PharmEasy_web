import 'package:flutter/material.dart';
import 'package:medicine_warehouse/warehouse_owner_screens/Dashboard.dart';
import 'package:medicine_warehouse/warehouse_owner_screens/home_page.dart';
import 'package:medicine_warehouse/warehouse_owner_screens/products_screen.dart';
import 'package:medicine_warehouse/warehouse_owner_widgets/Item_Details.dart';
import 'package:medicine_warehouse/warehouse_owner_widgets/add_medicine.dart';
import 'package:provider/provider.dart';
import 'models/Auth.dart';
import 'models/medicines.dart';
import 'start_page.dart';
import 'warehouse_owner_screens/web_auth_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {


    return
      MultiProvider(
          providers: [
    ChangeNotifierProvider(create: (_) => Auth()),ChangeNotifierProxyProvider<Auth,MedicinesList>(
        create: (_) => MedicinesList([]), // Create your Products instance here.
    update: (ctx, auth, previousProducts) => MedicinesList(
    previousProducts == null ? [] : previousProducts.medicines,
              ),
            ),
          ],
        child: MaterialApp(
          theme: ThemeData(
            primaryColor: Colors.blueAccent,
            accentColor: Colors.greenAccent,
            // Add more theme properties
          ),
          debugShowCheckedModeBanner: false,
          home:StartPage(),

          routes: {
            StartPage.routeName:(ctx)=>StartPage(),
            WebAuthScreen.routeName: (ctx) => WebAuthScreen(),
            HomePage.routeName : (ctx) => HomePage(),
            ProductsScreen.routeName:(ctx)=>ProductsScreen(),
            MedicineAddScreen.routeName:(ctx)=>MedicineAddScreen(),
            MedicineDetailsCard.routeName:(ctx)=>MedicineDetailsCard(),

          },



        )
    );

  }
}
