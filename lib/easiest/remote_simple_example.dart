import 'package:easiest_localization/easiest_localization.dart';
import 'package:easiest_remote_localization/easiest_remote_localization.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// Create a list of providers, which will be responsible for retrieving remote content
  late final List<LocalizationProvider<LocalizationMessages>> remoteProviders = [
    RemoteLocalizationProvider<LocalizationMessages>(
      sources: [
        /// Define a list of the sources - one per each desired language or country
        RemoteSource(
          locale: Locale('en'),

          /// Path can be anything remote url. In this example it is just a path to some CDN-file
          url: 'https://indieloper.b-cdn.net/easiest_localization/en.json',

          /// Set a type of the response - JSON or YAML
          type: SourceType.json,
        ),
        RemoteSource(
          locale: Locale('en', 'CA'),
          url: 'https://indieloper.b-cdn.net/easiest_localization/en_CA.json',
          type: SourceType.json,
        ),
        RemoteSource(
          locale: Locale('es'),
          url: 'https://indieloper.b-cdn.net/easiest_localization/es.json',
          type: SourceType.json,
        ),
        RemoteSource(
          locale: Locale('ru'),
          url: 'https://indieloper.b-cdn.net/easiest_localization/ru.json',
          type: SourceType.json,
        ),
      ],

      /// Define a [.fromJson(Map<String, dynamic> json)] constructor for your generated class, which will contain all the content
      factory: (RemoteSource source, Json content) => LocalizationMessages.fromJson(content),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (BuildContext context) => el.appTitle,

      /// Use [localizationsDelegatesWithProviders] instead of [localizationDelegates]
      localizationsDelegates: localizationsDelegatesWithProviders(remoteProviders),

      /// And [supportedLocalesWithProviders] instead of [supportedLocales]
      supportedLocales: supportedLocalesWithProviders(remoteProviders),
      home: Scaffold(),
    );
  }
}
