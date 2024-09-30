import 'package:intl/intl.dart' as intl;

import 'flutter_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Aplicación de Biblioteca';

  @override
  String language({required String language}) {
    return 'Idioma: $language';
  }

  @override
  String mainScreenGreetings({required String username}) {
    return '¡Hola, $username!';
  }

  @override
  String get mainScreenBooksAdd => 'Añadir libro';

  @override
  String mainScreenBooksAmountOfNew({required int howMany}) {
    String _temp0 = intl.Intl.pluralLogic(
      howMany,
      locale: localeName,
      other: 'Hay $howMany libros nuevos disponibles :)',
      one: 'Hay $howMany libro nuevo disponible :)',
      zero: 'No hay libros nuevos disponibles en este momento :(',
    );
    return '$_temp0';
  }

  @override
  String get mainScreenBooksTodayDateFormat => 'dd/MM/yyyy';

  @override
  String get mainScreenBooksWelcome => '# ¡Bienvenido a nuestra biblioteca!\n---\n## Estamos muy contentos de verte y nos gustaría que disfrutes leyendo nuestros libros.';

  @override
  String author({required String name, required String gender}) {
    String _temp0 = intl.Intl.selectLogic(
      gender,
      {
        'male': '¡$name es el autor de ese libro!',
        'female': '¡$name es la autora de ese libro!',
        'other': '¡$name es el autor de ese libro!',
      },
    );
    return '$_temp0';
  }

  @override
  String get privacyPolicyUrl => 'https://library.app/privacy_mx.pdf';

  @override
  String get employees0 => 'Juan Smith';

  @override
  String get employees1 => 'Alicia Johnson';

  @override
  String get employees2 => 'Miguel Brown';

  @override
  String get employees3 => 'Emma Davis';

  @override
  String get employees4 => 'Guillermo Taylor';
}
