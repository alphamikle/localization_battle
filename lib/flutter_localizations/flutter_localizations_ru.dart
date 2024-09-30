import 'package:intl/intl.dart' as intl;

import 'flutter_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get source => 'Flutter Localizations';

  @override
  String get appTitle => 'Библиотека';

  @override
  String language({required String language, required Object country}) {
    return 'Язык: $language';
  }

  @override
  String mainScreenGreetings({required String username}) {
    return 'Привет, $username!';
  }

  @override
  String get mainScreenBooksAdd => 'Добавить книгу';

  @override
  String mainScreenBooksAmountOfNew({required int howMany}) {
    String _temp0 = intl.Intl.pluralLogic(
      howMany,
      locale: localeName,
      other: 'В настоящий момент доступно $howMany новые книги :)',
      many: 'В настоящий момент доступно $howMany новых книг :)',
      few: 'В настоящий момент доступно $howMany новые книги :)',
      two: 'В настоящий момент доступны $howMany новые книги :)',
      one: 'В настоящий момент доступна $howMany новая книга :)',
      zero: 'В настоящий момент доступных новых книг нет :(',
    );
    return '$_temp0';
  }

  @override
  String get mainScreenBooksTodayDateFormat => 'dd MMM yyyy';

  @override
  String get mainScreenBooksWelcome => '# Добро пожаловать в нашу библиотеку!\n---\n## Мы очень рады вас видеть и хотели бы, чтобы вы получали удовольствие от чтения наших книг.';

  @override
  String author({required String name, required String gender}) {
    String _temp0 = intl.Intl.selectLogic(
      gender,
      {
        'male': '$name - он автор этой книги!',
        'female': '$name - она автор этой книги!',
        'other': '$name - автор этой книги!',
      },
    );
    return '$_temp0';
  }

  @override
  String get privacyPolicyUrl => 'https://library.app/privacy_ru.pdf';

  @override
  String get employees0 => 'Джон Смит';

  @override
  String get employees1 => 'Алиса Джонсон';

  @override
  String get employees2 => 'Майкл Браун';

  @override
  String get employees3 => 'Эмма Дэвис';

  @override
  String get employees4 => 'Уильям Тейлор';
}
