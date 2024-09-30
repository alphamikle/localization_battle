import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../flutter_localizations/flutter_localizations.dart';
import 'localizer.dart';

class BaseApp<G> extends StatefulWidget {
  const BaseApp({
    required this.localizer,
    super.key,
  });

  final Localizer<G> localizer;

  @override
  BaseAppState<G> createState() => BaseAppState<G>();
}

class BaseAppState<G> extends State<BaseApp<G>> {
  Localizer<G> get localizer => widget.localizer;

  Locale? localeOverride;

  Future<void> onLocaleSwitched(BuildContext context, Locale locale) async {
    setState(() => localeOverride = locale);
    localizer.onLocaleSwitched(context, locale);
  }

  List<LocalizationsDelegate> delegates() => localizer.delegates(context);

  List<Locale> locales() => localizer.locales(context);

  String appTitle() => localizer.appTitle(context);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) => MaterialApp(
        onGenerateTitle: (BuildContext context) => appTitle(),
        localizationsDelegates: delegates(),
        supportedLocales: locales(),
        locale: localeOverride,
        home: Home(
          localizer: localizer,
          onLocaleSwitched: (Locale locale) => onLocaleSwitched(
            context,
            locale,
          ),
        ),
      ),
    );
  }
}

class Home<G> extends StatefulWidget {
  const Home({
    required this.onLocaleSwitched,
    required this.localizer,
    super.key,
  });

  final ValueChanged<Locale> onLocaleSwitched;
  final Localizer<G> localizer;

  @override
  HomeState<G> createState() => HomeState<G>();
}

class HomeState<G> extends State<Home<G>> {
  Localizer<G> get localizer => widget.localizer;

  late Locale selectedLocale = defaultSelectedLocale(context);
  int booksAmount = 0;

  void switchLanguage(Set<Locale> selected) {
    if (selected.isNotEmpty) {
      setState(() => selectedLocale = selected.first);
      widget.onLocaleSwitched(selected.first);
    }
  }

  void addBook() => setState(() => booksAmount++);

  ButtonSegment<Locale> segmentBuilder(BuildContext context, int index) {
    final Locale locale = Localizations.localeOf(context);

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

  Locale defaultSelectedLocale(BuildContext context) => localizer.defaultSelectedLocale(context);

  G pickGender() => localizer.pickGender(context, booksAmount);

  String pickName() => localizer.pickName(context, booksAmount);

  List<String> get employees => localizer.employees(context);

  String greetings(String name) => localizer.greetings(context, name);

  String todayDate(DateTime date) => localizer.todayDate(context, date);

  String welcome() => localizer.welcome(context);

  String author(String name, G gender) => localizer.author(context, name, gender);

  String privacyPolicy() => localizer.privacyPolicy(context);

  String amountOfBooks(int amount) => localizer.amountOfBooks(context, amount);

  String addBooks() => localizer.addBooks(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(greetings(pickName())),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...text(todayDate(DateTime.now())),
          ...text(welcome()),
          ...text(author(pickName(), pickGender())),
          ...text(privacyPolicy()),
          for (final String employee in employees) ...text(employee),
          ...text(
            amountOfBooks(booksAmount),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
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
        tooltip: addBooks(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
