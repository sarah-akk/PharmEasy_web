import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medicine_warehouse/warehouse_owner_screens/home_page.dart';
import 'package:medicine_warehouse/warehouse_owner_screens/orders_screen.dart';
import 'package:medicine_warehouse/warehouse_owner_screens/products_screen.dart';
import 'package:medicine_warehouse/warehouse_owner_widgets/Item_Details.dart';
import 'package:medicine_warehouse/warehouse_owner_screens/add_medicine.dart';
import 'package:provider/provider.dart';
import 'Lang/codegen_loader.g.dart';
import 'models/Auth.dart';
import 'models/medicines.dart';
import 'models/orders.dart';
import 'start_page.dart';
import 'warehouse_owner_screens/web_auth_screen.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
      EasyLocalization(
      path: 'assets/Lang',
      supportedLocales: [
        Locale('en'),
        Locale('ar'),
      ],
      fallbackLocale: Locale('en'),
      assetLoader: CodegenLoader(),
      child: MyApp()
      )
  );
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => Auth()),

            ChangeNotifierProxyProvider<Auth, MedicinesList>(
              create: (_) => MedicinesList('', '', []),
              // Create your Products instance here.
              update: (ctx, auth, previousProducts) =>
                  MedicinesList(
                    auth.token,
                    auth.userId,
                    previousProducts == null ? [] : previousProducts.medicines,
                  ),
            ),
            ChangeNotifierProxyProvider<Auth, Orders>(
              create: (_) => Orders('', '', []),
              // Create your Products instance here.
              update: (ctx, auth, previousOrder) =>
                  Orders(
                    auth.token,
                    auth.userId,
                    previousOrder == null ? [] : previousOrder.oorders,
                  ),
            ),
          ],
          child: MaterialApp(
            theme: ThemeData(
              primaryColor: Colors.blueAccent,
              hintColor: Colors.greenAccent,
              // Add more theme properties
            ),
            debugShowCheckedModeBanner: false,
            home: StartPage(),

            routes: {
              StartPage.routeName: (ctx) => StartPage(),
              WebAuthScreen.routeName: (ctx) => WebAuthScreen(),
              HomePage.routeName: (ctx) => HomePage(),
              ProductsScreen.routeName: (ctx) => ProductsScreen(),
              MedicineAddScreen.routeName: (ctx) => MedicineAddScreen(),
              MedicineDetailsCard.routeName: (ctx) => MedicineDetailsCard(),
              OrdersScreen.routeName: (ctx) => OrdersScreen(),

            },

            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            locale: context.locale,

          )
      );
  }
}