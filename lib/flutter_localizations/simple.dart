import 'package:el_comparison/flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';

typedef Greetings = String Function({required String username});

void showExample(BuildContext context) {
  /// The only way to localize an application with flutter_localizations is shown below.
  /// There is no option with remote location of localization files.

  final AppLocalizations loc = AppLocalizations.of(context)!;

  final String simple = loc.appTitle;

  final Locale locale = Localizations.localeOf(context);
  final String withArgument = loc.language(language: locale.languageCode, country: locale.countryCode ?? '');

  final String kindaNested = loc.mainScreenBooksTodayDateFormat;

  const int booksAmount = 3;
  final String kindaNestedAndPlural = loc.mainScreenBooksAmountOfNew(howMany: booksAmount);

  final String genderWithArgument = loc.author(gender: 'female', name: 'Grace');

  /// Sometimes it can be useful to iterate content items as a list
  /// when there is a set of repetitive and structurally equal items.
  ///
  /// The only way to do this in flutter_localizations is to manually create the list
  /// And don't forget to add here a new employees!
  final List<String> names = [
    loc.employees0,
    loc.employees1,
    loc.employees2,
    loc.employees3,
    loc.employees4,
  ];
}
