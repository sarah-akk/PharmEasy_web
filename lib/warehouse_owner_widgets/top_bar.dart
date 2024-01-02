import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medicine_warehouse/Lang/Locale_keys_.g.dart';
import 'package:provider/provider.dart';

class TopBar extends StatefulWidget {
  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {

  void _changeLanguage(String languageCode) {
    context.setLocale(Locale(languageCode));
  }

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
                    label: Text(LocaleKeys.Notifications.tr(),style: TextStyle(fontSize: 20),),
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
              Text(LocaleKeys.settings.tr(),style: TextStyle(color: Colors.lightBlue,fontSize: 20),),
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