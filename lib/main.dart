import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'easy_main.dart' as easy;
import 'easiest_main.dart' as easiest;

enum Package {
  easy,
  easiest,
}

Package get package => Package.easy;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final AsyncCallback runner = switch (package) {
    Package.easy => easy.main,
    Package.easiest => easiest.main,
  };

  await runner();
}
