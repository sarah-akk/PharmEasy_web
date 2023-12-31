import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/Language.dart';

class TopBar extends StatefulWidget {
  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
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
                    label: Text('Notifications',style: TextStyle(fontSize: 20),),
                    onPressed: () {},
                  ),
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
                  )
                ],
              ),
              SizedBox(
                width: 20,
              ),
              PopupMenuButton<int>(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                          child: Icon(Icons.print),
                        ),
                        Text('Print'),
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
                        Text('Share'),
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
                        Text('Language'),
                        SizedBox(width: 10),
                        DropdownButton<String>(
                          value: Provider.of<Language>(context, listen: false).locale.languageCode,
                          items: [
                            DropdownMenuItem(
                              value: 'en',
                              child: Text('English'),
                            ),
                            DropdownMenuItem(
                              value: 'ar',
                              child: Text('Arabic'),
                            ),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              Provider.of<Language>(context, listen: false).changeLanguage(Locale(value));
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text('settings',style: TextStyle(color: Colors.lightBlue,fontSize: 20),),
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
