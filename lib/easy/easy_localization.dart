// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ru = {
  "app_title": "Библиотека",
  "language": "Язык: {language}",
  "main_screen": {
    "greetings": "Привет, {username}!",
    "books": {
      "add": "Добавить книгу",
      "amount_of_new": {
        "zero": "В настоящий момент доступных новых книг нет :(",
        "one": "В настоящий момент доступна {howMany} новая книга :)",
        "two": "В настоящий момент доступны {howMany} новые книги :)",
        "few": "В настоящий момент доступно {howMany} новые книги :)",
        "many": "В настоящий момент доступно {howMany} новых книг :)",
        "other": "В настоящий момент доступно {howMany} новые книги :)"
      }
    },
    "today_date_format": "DD MMM yyyy",
    "welcome": "# Добро пожаловать в нашу библиотеку!\n---\n## Мы очень рады вас видеть и хотели бы, чтобы вы получали удовольствие от чтения наших книг.\n"
  },
  "author": {
    "male": "{name} - он автор этой книги!",
    "female": "{name} - она автор этой книги!",
    "other": "{name} - автор этой книги!"
  },
  "privacy_policy_url": "https://library.app/privacy_ru.pdf",
  "employees": {
    "0": "Джон Смит",
    "1": "Алиса Джонсон",
    "2": "Майкл Браун",
    "3": "Эмма Дэвис",
    "4": "Уильям Тейлор"
  },
  "source": "Easiest Localization"
};
static const Map<String,dynamic> en_CA = {
  "app_title": "Library App",
  "language": "Lang: {language}; Country: {country}",
  "main_screen": {
    "greetings": "Hello, {username}!",
    "books": {
      "add": "Add Book",
      "amount_of_new": {
        "zero": "There are no new books available at the moment :(",
        "one": "There is {howMany} new book available :)",
        "two": "",
        "few": "",
        "many": "",
        "other": "There are {howMany} new books available :)"
      }
    },
    "today_date_format": "dd/MM/yyyy",
    "welcome": "# Welcome to our library!\n---\n## We are very happy to see you and would like you to enjoy reading our books.\n"
  },
  "author": {
    "male": "{name} - he is the author of that book!",
    "female": "{name} - she is the author of that book!",
    "other": "{name} - they are the author of that book!"
  },
  "privacy_policy_url": "https://library.app/privacy_ca.pdf",
  "employees": {
    "0": "John Smith",
    "1": "Alice Johnson",
    "2": "Michael Brown",
    "3": "Emma Davis",
    "4": "William Taylor"
  },
  "source": "Easiest Localization"
};
static const Map<String,dynamic> en = {
  "app_title": "Library App",
  "language": "Lang: {language}",
  "main_screen": {
    "greetings": "Hello, {username}!",
    "books": {
      "add": "Add Book",
      "amount_of_new": {
        "zero": "There are no new books available at the moment :(",
        "one": "There is {howMany} new book available :)",
        "two": "",
        "few": "",
        "many": "",
        "other": "There are {howMany} new books available :)"
      }
    },
    "today_date_format": "MM/dd/yyyy",
    "welcome": "# Welcome to our library!\n---\n## We are very happy to see you and would like you to enjoy reading our books.\n"
  },
  "author": {
    "male": "{name} - he is the author of that book!",
    "female": "{name} - she is the author of that book!",
    "other": "{name} - they are the author of that book!"
  },
  "privacy_policy_url": "https://library.app/privacy_us.pdf",
  "employees": {
    "0": "John Smith",
    "1": "Alice Johnson",
    "2": "Michael Brown",
    "3": "Emma Davis",
    "4": "William Taylor"
  },
  "source": "Easiest Localization"
};
static const Map<String,dynamic> es = {
  "app_title": "Aplicación de Biblioteca",
  "language": "Idioma: {language}",
  "main_screen": {
    "greetings": "¡Hola, {username}!",
    "books": {
      "add": "Añadir libro",
      "amount_of_new": {
        "zero": "No hay libros nuevos disponibles en este momento :(",
        "one": "Hay {howMany} libro nuevo disponible :)",
        "two": "",
        "few": "",
        "many": "",
        "other": "Hay {howMany} libros nuevos disponibles :)"
      }
    },
    "today_date_format": "dd/MM/yyyy",
    "welcome": "# ¡Bienvenido a nuestra biblioteca!\n---\n## Estamos muy contentos de verte y nos gustaría que disfrutes leyendo nuestros libros.\n"
  },
  "author": {
    "male": "¡{name} es el autor de ese libro!",
    "female": "¡{name} es la autora de ese libro!",
    "other": "¡{name} es el autor de ese libro!"
  },
  "privacy_policy_url": "https://library.app/privacy_mx.pdf",
  "employees": {
    "0": "Juan Smith",
    "1": "Alicia Johnson",
    "2": "Miguel Brown",
    "3": "Emma Davis",
    "4": "Guillermo Taylor"
  },
  "source": "Easiest Localization"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ru": ru, "en_CA": en_CA, "en": en, "es": es};
}
