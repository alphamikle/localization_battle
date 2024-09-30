import 'package:flutter/material.dart';

abstract class Localizer<G> {
  Future<void> initMain();

  List<LocalizationsDelegate> delegates(BuildContext context);

  List<Locale> locales(BuildContext context);

  Future<void> onLocaleSwitched(BuildContext context, Locale locale);

  String appTitle(BuildContext context);

  Locale defaultSelectedLocale(BuildContext context);

  G pickGender(BuildContext context, int booksAmount);

  String pickName(BuildContext context, int booksAmount);

  List<String> employees(BuildContext context);

  String greetings(BuildContext context, String name);

  String todayDate(BuildContext context, DateTime date);

  String welcome(BuildContext context);

  String author(BuildContext context, String name, G gender);

  String privacyPolicy(BuildContext context);

  String amountOfBooks(BuildContext context, int amount);

  String addBooks(BuildContext context);
}
