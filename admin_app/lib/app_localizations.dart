import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(
        context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      AppLocalizationsDelegate();

  static const localizedValues = {
    'en': {
      'bookings': 'Bookings',
      'incoming': 'Incoming Bookings',
      'past': 'Past Bookings',
    },
    'ar': {
      'bookings': 'الحجوزات',
      'incoming': 'الحجوزات القادمة',
      'past': 'الحجوزات السابقة',
    },
  };

  String get bookings =>
      localizedValues[locale.languageCode]!['bookings']!;

  String get incoming =>
      localizedValues[locale.languageCode]!['incoming']!;

  String get past =>
      localizedValues[locale.languageCode]!['past']!;

}

class AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_) => false;
}
