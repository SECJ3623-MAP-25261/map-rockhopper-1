import 'package:flutter/material.dart';

class LanguageNotifier extends ChangeNotifier {
  Locale _currentLocale = Locale('en'); // default English
  Locale get currentLocale => _currentLocale;

  void switchLanguage(String languageCode) {
    _currentLocale = Locale(languageCode);
    notifyListeners();
  }
}
