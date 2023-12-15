import 'package:flutter/material.dart';

class Language extends ChangeNotifier {
  Locale _locale = Locale('en'); // Default language is English

  Locale get locale => _locale;

  void changeLanguage(Locale newLocale) {
    _locale = newLocale;
    notifyListeners();
  }
}
