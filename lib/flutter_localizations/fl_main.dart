import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'flutter_localizations.dart';

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
  Locale? localeOverride;

  Future<void> onLocaleSwitched(BuildContext context, Locale locale) async {
    setState(() => localeOverride = locale);
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) => MaterialApp(
        onGenerateTitle: (BuildContext context) => context.loc.appTitle,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: localeOverride,
        home: Home(
          onLocaleSwitched: (Locale locale) => onLocaleSwitched(context, locale),
        ),
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

  String pickGender() => switch (booksAmount % 3) {
        0 => 'male',
        1 => 'female',
        _ => 'other',
      };

  void switchLanguage(Set<Locale> selected) {
    if (selected.isNotEmpty) {
      setState(() => selectedLocale = selected.first);
      widget.onLocaleSwitched(selected.first);
    }
  }

  String pickName() {
    final List<String> names = employees;
    return names[booksAmount % names.length].toString();
  }

  void addBook() {
    setState(() {
      booksAmount++;
    });
  }

  ButtonSegment<Locale> segmentBuilder(BuildContext context, int index) {
    final Locale locale = AppLocalizations.supportedLocales[index];

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

  List<String> get employees {
    return [
      context.loc.employees0,
      context.loc.employees1,
      context.loc.employees2,
      context.loc.employees3,
      context.loc.employees4,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(context.loc.mainScreenGreetings(username: pickName())),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...text(DateFormat(context.loc.mainScreenBooksTodayDateFormat).format(DateTime.now())),
          ...text(context.loc.mainScreenBooksWelcome, md: true),
          ...text(context.loc.author(name: pickName(), gender: pickGender())),
          ...text(context.loc.privacyPolicyUrl),
          for (final String employee in employees) ...text(employee),
          ...text(
            context.loc.mainScreenBooksAmountOfNew(howMany: booksAmount),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...text(context.loc.language(language: Localizations.localeOf(context).languageCode, country: Localizations.localeOf(context).countryCode ?? '')),
          ...text(context.loc.source),
          SegmentedButton<Locale>(
            segments: List.generate(AppLocalizations.supportedLocales.length, (int index) => segmentBuilder(context, index)),
            selected: {
              selectedLocale,
            },
            onSelectionChanged: switchLanguage,
            emptySelectionAllowed: true,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addBook,
        tooltip: context.loc.mainScreenBooksAdd,
        child: const Icon(Icons.add),
      ),
    );
  }
}

extension LocalizedContext on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this)!;
}
