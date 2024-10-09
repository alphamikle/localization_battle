import 'package:easiest_localization/easiest_localization.dart';
import 'package:easiest_remote_localization/easiest_remote_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';
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
  /// Create remote providers - as many, as you want. But usually, you will need only one
  late final List<LocalizationProvider<LocalizationMessages>> remoteProviders = [
    // RemoteLocalizationProvider.raw(
    //   service: RemoteLocalizationService(
    //     Dio(
    //       BaseOptions(/*...*/),
    //     ),
    //   ),
    //   sources: <RemoteSource>[],
    //   factory: (RemoteSource source, Json content) => LocalizationMessages.fromJson(content),
    //   supportedLocales: <Locale>[],
    //   sharedPreferences: SharedPreferences.instance,
    //   cacheTTL: const Duration(hours: 3),
    // ),
    RemoteLocalizationProvider<LocalizationMessages>(
      /// Set the cache duration
      /// During this time, the user will use the previously downloaded content
      cacheTTL: const Duration(hours: 3),

      /// If necessary - you can configure in detail how exactly the network request will be executed with Dio' BaseOptions
      options: BaseOptions(),
      sources: [
        /// Describe the “sources” for each of the supported languages
        ///
        /// Hint - since “source” is a very simple dataclass, it is quite easy to implement getting the sources themselves completely remotely.
        /// This way you can change not only the content of already supported languages, but also add new languages dynamically.
        RemoteSource(
          locale: Locale('en'),
          url: 'https://indieloper.b-cdn.net/easiest_localization/en.json',
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

      /// Specify factory `.fromJson` from the generated class with localized content
      /// If you have not changed the settings, this line will look exactly the same
      /// If you have changed the `class_name` parameter - this will be `<class_name>.fromJson`
      factory: (RemoteSource source, Json content) => LocalizationMessages.fromJson(content),
    ),
  ];

  Locale? localeOverride;

  void onLocaleSwitched(Locale locale) {
    setState(() => localeOverride = locale);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (BuildContext context) => el.appTitle,

      /// Use localizationsDelegatesWithProviders(remoteProviders) instead of localizationsDelegates
      localizationsDelegates: localizationsDelegatesWithProviders(remoteProviders),

      /// And finally - use supportedLocalesWithProviders(remoteProviders) instead of supportedLocales
      supportedLocales: supportedLocalesWithProviders(remoteProviders),
      locale: localeOverride,
      home: Home(
        onLocaleSwitched: onLocaleSwitched,
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({
    required this.onLocaleSwitched,
    super.key,
  });

  final ValueChanged<Locale> onLocaleSwitched;

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  late Locale selectedLocale = Localizations.localeOf(context);
  int booksAmount = 0;

  void syncLocaleWithSystem() => selectedLocale = Localizations.localeOf(context);

  Gender pickGender() => switch (booksAmount % 3) {
        0 => Gender.male,
        1 => Gender.female,
        _ => Gender.other,
      };

  void switchLanguage(Set<Locale> selected) {
    if (selected.isNotEmpty) {
      setState(() => selectedLocale = selected.first);
      widget.onLocaleSwitched(selected.first);
    }
  }

  String pickName() {
    final List<Object> names = el.employees.contentList;
    return names[booksAmount % names.length].toString();
  }

  void addBook() {
    setState(() {
      booksAmount++;
    });
  }

  ButtonSegment<Locale> segmentBuilder(BuildContext context, int index) {
    final Locale locale = supportedLocales[index];

    return ButtonSegment(
      value: locale,
      label: Text(
        locale.toLanguageTag(),
      ),
    );
  }

  List<Widget> text(
    String text, {
    bool last = false,
    TextStyle? style,
    bool md = false,
  }) {
    return [
      md
          ? MarkdownBody(data: text)
          : Text(
              text,
              style: style,
            ),
      if (last != true) const Divider(),
    ];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    syncLocaleWithSystem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(el.mainScreen.greetings(username: pickName())),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...text(DateFormat(el.mainScreen.todayDateFormat).format(DateTime.now())),
          ...text(el.mainScreen.welcome, md: true),
          ...text(el.author(pickGender(), name: pickName())),
          ...text(el.privacyPolicyUrl),
          for (final Object employee in el.employees.contentList) ...text(employee.toString()),
          ...text(
            el.mainScreen.books.amountOfNew(booksAmount),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...text(el.language(language: selectedLocale.languageCode, country: selectedLocale.countryCode ?? '')),
          ...text(el.source),
          SegmentedButton<Locale>(
            segments: List.generate(supportedLocales.length, (int index) => segmentBuilder(context, index)),
            selected: {selectedLocale},
            onSelectionChanged: switchLanguage,
            emptySelectionAllowed: true,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addBook,
        tooltip: el.mainScreen.books.add,
        child: const Icon(Icons.add),
      ),
    );
  }
}
