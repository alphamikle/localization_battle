import 'package:easy_localization/easy_localization.dart';
import 'package:el_comparison/localizer/localizer.dart';
import 'package:flutter/material.dart';

class EasyLocalizer extends Localizer<String> {
  @override
  String addBooks(BuildContext context) => 'main_screen.books.add'.tr();

  @override
  String amountOfBooks(BuildContext context, int amount) => 'main_screen.books.amount_of_new'.plural(amount, name: 'howMany');

  @override
  String appTitle(BuildContext context) => 'app_title'.tr();

  @override
  String author(BuildContext context, String name, String gender) => 'author'.tr(namedArgs: {'name': name}, gender: gender);

  @override
  Locale defaultSelectedLocale(BuildContext context) => context.locale;

  @override
  List<LocalizationsDelegate> delegates(BuildContext context) => context.localizationDelegates;

  @override
  List<String> employees(BuildContext context) => List.generate(
        // This number will be always hardcoded
        5,
        (int index) => 'employees.$index'.tr(),
      );

  @override
  String greetings(BuildContext context, String name) => 'main_screen.greetings'.tr(namedArgs: {'username': name});

  @override
  Future<void> initMain() async => await EasyLocalization.ensureInitialized();

  @override
  List<Locale> locales(BuildContext context) => context.supportedLocales;

  @override
  Future<void> onLocaleSwitched(BuildContext context, Locale locale) async => await context.setLocale(locale);

  @override
  String pickGender(BuildContext context, int booksAmount) => switch (booksAmount % 3) {
        0 => 'male',
        1 => 'female',
        _ => 'other',
      };

  @override
  String pickName(BuildContext context, int booksAmount) {
    final List<String> names = employees(context);
    return names[booksAmount % names.length].toString();
  }

  @override
  String privacyPolicy(BuildContext context) => 'privacy_policy_url'.tr();

  @override
  String todayDate(BuildContext context, DateTime date) => DateFormat('main_screen.today_date_format'.tr()).format(DateTime.now());

  @override
  String welcome(BuildContext context) => 'main_screen.welcome'.tr();
}
