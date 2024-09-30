import 'package:intl/intl.dart' as intl;

import 'flutter_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get source => 'Flutter Localizations';

  @override
  String get appTitle => 'Library App';

  @override
  String language({required String language, required Object country}) {
    return 'Lang: $language';
  }

  @override
  String mainScreenGreetings({required String username}) {
    return 'Hello, $username';
  }

  @override
  String get mainScreenBooksAdd => 'Add Book';

  @override
  String mainScreenBooksAmountOfNew({required int howMany}) {
    String _temp0 = intl.Intl.pluralLogic(
      howMany,
      locale: localeName,
      other: 'There are $howMany new books available :)',
      one: 'There is $howMany new book available :)',
      zero: 'There are no new books available at the moment :(',
    );
    return '$_temp0';
  }

  @override
  String get mainScreenBooksTodayDateFormat => 'MM/dd/yyyy';

  @override
  String get mainScreenBooksWelcome => '# Welcome to our library!\n---\n## We are very happy to see you and would like you to enjoy reading our books.';

  @override
  String author({required String name, required String gender}) {
    String _temp0 = intl.Intl.selectLogic(
      gender,
      {
        'male': '$name - he is the author of that book!',
        'female': '$name - she is the author of that book!',
        'other': '$name - they are the author of that book!',
      },
    );
    return '$_temp0';
  }

  @override
  String get privacyPolicyUrl => 'https://library.app/privacy_us.pdf';

  @override
  String get employees0 => 'John Smith';

  @override
  String get employees1 => 'Alice Johnson';

  @override
  String get employees2 => 'Michael Brown';

  @override
  String get employees3 => 'Emma Davis';

  @override
  String get employees4 => 'William Taylor';
}

/// The translations for English, as used in Canada (`en_CA`).
class AppLocalizationsEnCa extends AppLocalizationsEn {
  AppLocalizationsEnCa(): super('en_CA');

  @override
  String get source => 'Flutter Localizations';

  @override
  String get appTitle => 'Library App';

  @override
  String language({required String language, required Object country}) {
    return 'Lang: \$$language; Country: \$$country';
  }

  @override
  String mainScreenGreetings({required String username}) {
    return 'Hello, $username';
  }

  @override
  String get mainScreenBooksAdd => 'Add Book';

  @override
  String mainScreenBooksAmountOfNew({required int howMany}) {
    String _temp0 = intl.Intl.pluralLogic(
      howMany,
      locale: localeName,
      other: 'There are $howMany new books available :)',
      one: 'There is $howMany new book available :)',
      zero: 'There are no new books available at the moment :(',
    );
    return '$_temp0';
  }

  @override
  String get mainScreenBooksTodayDateFormat => 'dd/MM/yyyy';

  @override
  String get mainScreenBooksWelcome => '# Welcome to our library!\n---\n## We are very happy to see you and would like you to enjoy reading our books.';

  @override
  String author({required String name, required String gender}) {
    String _temp0 = intl.Intl.selectLogic(
      gender,
      {
        'male': '$name - he is the author of that book!',
        'female': '$name - she is the author of that book!',
        'other': '$name - they are the author of that book!',
      },
    );
    return '$_temp0';
  }

  @override
  String get privacyPolicyUrl => 'https://library.app/privacy_ca.pdf';

  @override
  String get employees0 => 'John Smith';

  @override
  String get employees1 => 'Alice Johnson';

  @override
  String get employees2 => 'Michael Brown';

  @override
  String get employees3 => 'Emma Davis';

  @override
  String get employees4 => 'William Taylor';
}
