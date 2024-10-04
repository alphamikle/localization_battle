import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

typedef Greetings = String Function({required String username});

void showExample(BuildContext context) {
  /// The only way to use easy_localization is shown below
  /// It will be the same for any “loader” - whether based on assemblies or code-generated / remote json files

  final String simple = 'app_title'.tr();

  final Locale locale = context.locale;
  final String withArgument = 'language'.tr(namedArgs: {'language': locale.languageCode, 'country': locale.countryCode ?? ''});

  final String nested = 'main_screen.today_date_format'.tr();

  const int booksAmount = 3;
  final String nestedAndPlural = 'main_screen.books.amount_of_new'.plural(booksAmount, name: 'howMany');

  final String genderWithArgument = 'author'.tr(gender: 'female', namedArgs: {'name': 'Grace'});

  /// Sometimes it can be useful to iterate content items as a list
  /// when there is a set of repetitive and structurally equal items.
  ///
  /// The only way to do this in easy_localization is to build the list yourself (which is ok),
  /// with a hardcoded number of elements (which is not ok, since that number can change).
  const int employeesAmount = 5;
  final List<String> names = List.generate(employeesAmount, (int index) => 'employees.$index'.tr());
}
