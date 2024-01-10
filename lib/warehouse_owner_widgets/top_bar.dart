import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medicine_warehouse/Lang/Locale_keys_.g.dart';
import 'package:medicine_warehouse/models/orders.dart';
import 'package:provider/provider.dart';


class TopBar extends StatefulWidget {
  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {

  bool hasNewNotifications = false; // Track whether there are new notifications

  void _changeLanguage(String languageCode) {
    context.setLocale(Locale(languageCode));
  }

  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((_) async {
      await Provider.of<Orders>(context, listen: false).fetchOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    String notificationManager = Provider
        .of<Orders>(context)
        .notifications;
    hasNewNotifications = Provider
        .of<Orders>(context)
        .notii;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 5),
            blurRadius: 17,
          ),
        ],
      ),
      height: 50,
      child: Row(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  TextButton.icon(
                    icon: Icon(Icons.notifications_sharp),
                    label: Text(LocaleKeys.Notifications.tr(),
                      style: TextStyle(fontSize: 20),),
                    onPressed: () {
                      _showNotificationsList(context, notificationManager);
                      hasNewNotifications = false;
                    },
                  ),
                  if (hasNewNotifications) // Show red mark if there are new notifications
                    Positioned(
                      top: 4,
                      left: 9,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              PopupMenuButton<int>(
                itemBuilder: (context) =>
                [
                  PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                          child: Icon(Icons.print),
                        ),
                        Text(LocaleKeys.Print.tr()),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                          child: Icon(Icons.share),
                        ),
                        Text(LocaleKeys.Share.tr()),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 3,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                          child: Icon(Icons.language),
                        ),
                        Text(LocaleKeys.Language.tr()),
                        SizedBox(width: 10),
                        DropdownButton<String>(
                          items: [
                            DropdownMenuItem(
                              value: 'en',
                              child: Text(LocaleKeys.English.tr()),
                            ),
                            DropdownMenuItem(
                              value: 'ar',
                              child: Text(LocaleKeys.Arabic.tr()),
                            ),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              _changeLanguage(value);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(LocaleKeys.settings.tr(),
                style: TextStyle(color: Colors.lightBlue, fontSize: 20),),
              SizedBox(
                width: 20,
              ),
            ],
          )
        ],
      ),
    );
  }
}

void _showNotificationsList(BuildContext context, String notifications) {
  if (notifications == '' || notifications.isEmpty) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            LocaleKeys.Notifications.tr(),
            style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),
          ),
          content: Text(
            LocaleKeys.NothingChanged.tr(),
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(LocaleKeys.Close.tr()),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            title: Text(LocaleKeys.Notifications.tr(), style: TextStyle(
                color: Colors.pink, fontWeight: FontWeight.bold),),
            content: Container(
              width: 300,
              height: 500, // Adjust the width as needed
              child: Column(
                  children:[
                    ListTile(
                      title: Text(
                        LocaleKeys.neworders.tr(),
                        style:  TextStyle(color: Colors
                            .blue
                        ),
                      ),
                    ),
                  ]
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(LocaleKeys.Close.tr()),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          ),
        );
      },
    );
  }
}



