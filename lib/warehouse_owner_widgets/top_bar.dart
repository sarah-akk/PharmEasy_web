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
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {},
              ),
              Stack(
                children: [
                  TextButton.icon(
                    icon: Icon(Icons.notifications_sharp),
                    label: Text('Notifications'),
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
              TextButton.icon(
                icon: Icon(Icons.settings),
                label: Text('Settings'),
                onPressed: () {
                  showPopupMenu(context);
                },
              ),
              SizedBox(
                width: 20,
              ),
            ],
          )
        ],
      ),
    );
  }

  void showPopupMenu(BuildContext context) {
    final RenderBox overlay = Overlay
        .of(context)
        .context
        .findRenderObject() as RenderBox;
    showMenu(
      context: context,
      position: RelativeRect.fromRect(
        Rect.fromPoints(
          Offset(500, 0),
          overlay.localToGlobal(overlay.size.bottomLeft(Offset.zero)),
        ),
        Offset.zero & overlay.size,
      ),
      items: [
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
                value: Provider
                    .of<Language>(context, listen: false)
                    .locale
                    .languageCode,
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
                    Provider.of<Language>(context, listen: false)
                        .changeLanguage(Locale(value));
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}