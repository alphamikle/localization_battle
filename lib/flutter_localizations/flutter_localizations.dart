import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'flutter_localizations_en.dart';
import 'flutter_localizations_es.dart';
import 'flutter_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'flutter_localizations/flutter_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('en', 'CA'),
    Locale('es'),
    Locale('ru')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Library App'**
  String get appTitle;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Lang: {language}'**
  String language({required String language});

  /// No description provided for @mainScreenGreetings.
  ///
  /// In en, this message translates to:
  /// **'Hello, {username}'**
  String mainScreenGreetings({required String username});

  /// No description provided for @mainScreenBooksAdd.
  ///
  /// In en, this message translates to:
  /// **'Add Book'**
  String get mainScreenBooksAdd;

  /// No description provided for @mainScreenBooksAmountOfNew.
  ///
  /// In en, this message translates to:
  /// **'{howMany, plural, zero{There are no new books available at the moment :(} one{There is {howMany} new book available :)} other{There are {howMany} new books available :)}}'**
  String mainScreenBooksAmountOfNew({required int howMany});

  /// No description provided for @mainScreenBooksTodayDateFormat.
  ///
  /// In en, this message translates to:
  /// **'MM/dd/yyyy'**
  String get mainScreenBooksTodayDateFormat;

  /// No description provided for @mainScreenBooksWelcome.
  ///
  /// In en, this message translates to:
  /// **'# Welcome to our library!\n---\n## We are very happy to see you and would like you to enjoy reading our books.'**
  String get mainScreenBooksWelcome;

  /// No description provided for @author.
  ///
  /// In en, this message translates to:
  /// **'{gender, select, male{{name} - he is the author of that book!} female{{name} - she is the author of that book!} other{{name} - they are the author of that book!}}'**
  String author({required String name, required String gender});

  /// No description provided for @privacyPolicyUrl.
  ///
  /// In en, this message translates to:
  /// **'https://library.app/privacy_us.pdf'**
  String get privacyPolicyUrl;

  /// No description provided for @employees0.
  ///
  /// In en, this message translates to:
  /// **'John Smith'**
  String get employees0;

  /// No description provided for @employees1.
  ///
  /// In en, this message translates to:
  /// **'Alice Johnson'**
  String get employees1;

  /// No description provided for @employees2.
  ///
  /// In en, this message translates to:
  /// **'Michael Brown'**
  String get employees2;

  /// No description provided for @employees3.
  ///
  /// In en, this message translates to:
  /// **'Emma Davis'**
  String get employees3;

  /// No description provided for @employees4.
  ///
  /// In en, this message translates to:
  /// **'William Taylor'**
  String get employees4;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {

  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'en': {
  switch (locale.countryCode) {
    case 'CA': return AppLocalizationsEnCa();
   }
  break;
   }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
    case 'ru': return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
