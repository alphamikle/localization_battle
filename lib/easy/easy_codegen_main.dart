import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:el_comparison/easy/easy_localization.dart';
import 'package:el_comparison/flutter_localizations/fl_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

Future<void> main() async {
  await EasyLocalization.ensureInitialized();
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
    await context.setLocale(locale);
    setState(() => localeOverride = locale);
  }

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
        Locale('ru'),
        Locale('en', 'CA'),
      ],

      /// ! In fact, it's not necessary here
      path: 'assets/i18n/easy',
      assetLoader: CodegenLoader(),
      child: Builder(
        builder: (BuildContext context) => MaterialApp(
          onGenerateTitle: (BuildContext context) => 'app_title'.tr(),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: localeOverride ?? context.locale,
          home: Home(
            onLocaleSwitched: (Locale locale) => onLocaleSwitched(context, locale),
          ),
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
  late Locale selectedLocale = context.locale;
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
    final Locale locale = context.supportedLocales[index];

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
    return List.generate(
      // This number will be always hardcoded
      5,
      (int index) => 'employees.$index'.tr(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('main_screen.greetings'.tr(namedArgs: {'username': pickName()})),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...text(DateFormat('main_screen.today_date_format'.tr()).format(DateTime.now())),
          ...text('main_screen.welcome'.tr(), md: true),
          ...text('author'.tr(namedArgs: {'name': pickName()}, gender: pickGender())),
          ...text('privacy_policy_url'.tr()),
          for (final String employee in employees) ...text(employee),
          ...text(
            'main_screen.books.amount_of_new'.plural(booksAmount, name: 'howMany'),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...text('language'.tr(namedArgs: {'language': context.locale.languageCode, 'country': context.locale.countryCode ?? ''})),
          ...text('source'.tr()),
          SegmentedButton<Locale>(
            segments: List.generate(context.supportedLocales.length, (int index) => segmentBuilder(context, index)),
            selected: {selectedLocale},
            onSelectionChanged: switchLanguage,
            emptySelectionAllowed: true,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addBook,
        tooltip: 'main_screen.books.add'.tr(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
