import 'package:easiest_localization/easiest_localization.dart';
import 'package:easiest_remote_localization/easiest_remote_localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:el_comparison/easiest/remote_sources_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:localization/localization.dart';

late final List<RemoteSource> remoteSources;

final List<LocalizationProvider<LocalizationMessages>> remoteProviders = [
  RemoteLocalizationProvider<LocalizationMessages>(
    sources: remoteSources,
    factory: (RemoteSource source, Json content) => LocalizationMessages.fromJson(content),
  ),
];

Future<void> main() async {
  remoteSources = await RemoteSourcesService().fetchSources();
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
  Locale? localeOverride;

  void onLocaleSwitched(Locale locale) {
    setState(() => localeOverride = locale);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (BuildContext context) => el.appTitle,
      localizationsDelegates: localizationsDelegatesWithProviders(remoteProviders),
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
    final Locale locale = Set.from(supportedLocalesWithProviders(remoteProviders)).toList()[index];

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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SegmentedButton<Locale>(
              segments: List.generate(Set.from(supportedLocalesWithProviders(remoteProviders)).length, (int index) => segmentBuilder(context, index)),
              selected: {selectedLocale},
              onSelectionChanged: switchLanguage,
              emptySelectionAllowed: true,
            ),
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
