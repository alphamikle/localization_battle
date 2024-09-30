import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'easy_main.dart' as easy;
import 'easiest_main.dart' as easiest;
import 'fl_main.dart' as fl;

enum Package {
  easy,
  easiest,
  fl,
}

Package get package => Package.fl;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final AsyncCallback runner = switch (package) {
    Package.easy => easy.main,
    Package.easiest => easiest.main,
    Package.fl => fl.main,
  };

  await runner();
}
