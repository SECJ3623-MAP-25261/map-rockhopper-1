/*import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Language provider
class LanguageNotifier extends ChangeNotifier {
  Locale _currentLocale = Locale('en'); // default English
  Locale get currentLocale => _currentLocale;

  void switchLanguage(String languageCode) {
    _currentLocale = Locale(languageCode);
    notifyListeners();
  }
}

// Language selection page
class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLang = context.watch<LanguageNotifier>().currentLocale.languageCode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Language'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            title: const Text('English'),
            leading: Radio<String>(
              value: 'en',
              groupValue: currentLang,
              onChanged: (value) {
                context.read<LanguageNotifier>().switchLanguage(value!);
              },
            ),
            onTap: () {
              context.read<LanguageNotifier>().switchLanguage('en');
            },
          ),
          ListTile(
            title: const Text('Bahasa Malaysia'),
            leading: Radio<String>(
              value: 'ms',
              groupValue: currentLang,
              onChanged: (value) {
                context.read<LanguageNotifier>().switchLanguage(value!);
              },
            ),
            onTap: () {
              context.read<LanguageNotifier>().switchLanguage('ms');
            },
          ),
        ],
      ),
    );
  }
}
*/