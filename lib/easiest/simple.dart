import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

typedef Greetings = String Function({required String username});

void showExample(BuildContext context) {
  /// Here is the most preferred way to use easiest_localization - type-safe and simple

  final String simple = el.appTitle;

  final Locale locale = Localizations.localeOf(context);
  final String withArgument = el.language(language: locale.languageCode, country: locale.countryCode ?? '');

  final String nested = el.mainScreen.todayDateFormat;

  /// This is a copy of the doc from [Intl.plural]'
  ///
  /// Selects the correct plural form from the provided alternatives.
  /// The [other] named argument is mandatory.
  /// The [precision] is the number of fractional digits that would be rendered
  /// when [howMany] is formatted. In some cases just knowing the numeric value
  /// of [howMany] itself is not enough, for example "1 mile" vs "1.00 miles"
  const int booksAmount = 3;
  final String nestedAndPlural = el.mainScreen.books.amountOfNew(booksAmount, precision: 0);

  final String genderWithArgument = el.author(Gender.female, name: 'Grace');

  /// Sometimes it can be useful to iterate content items as a list
  /// when there is a set of repetitive and structurally equal items.
  final List<Object> names = el.employees.contentList;

  /// -----------------------------------------------------------------------------------------------------------------------------

  /// Below are alternative ways to get the content.
  /// They are not very type-safe and it is the responsibility of the developer to ensure
  /// that a particular field turns out to be exactly what the developer expects.

  final String simpleWithTypeCast = el.getContent<String>('app_title'); // "Library App" OR an Exception, if the key is wrong

  final String nestedWithMultipleTypeCast = el.getContent<MainScreen>('main_screen').getContent<Greetings>('greetings')(username: 'Grace');

  final Object? dynamicV1 = el.employees[0]; // John Smith

  final Object? dynamicV2 = el['app_title']; // Library App

  final dynamic dynamicV3 = 'main_screen.greetings'.tr(); // String Function({required String username})

  final dynamic dynamicV4 = 'app_title'.el; // Library App

  final dynamic dynamicV5 = context.tr('app_title'); // Library App
}
