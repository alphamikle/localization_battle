import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'easy/easy_main.dart' as easy;
import 'easy/easy_codegen_main.dart' as easy_gen;
import 'easy/easy_remote_main.dart' as easy_remote;
import 'easiest/easiest_main.dart' as easiest;
import 'easiest/easiest_remote_main.dart' as easiest_remote;
import 'easiest/easiest_super_remote_main.dart' as easiest_super_remote;
import 'flutter_localizations/fl_main.dart' as fl;

enum Package {
  easy,
  easyGenerated,
  easyRemote,
  easiest,
  easiestRemote,
  easiestSuperRemote,
  fl,
}

const String source = String.fromEnvironment('SOURCE', defaultValue: 'fl');

Package get package => switch (source) {
      'easy' => Package.easy,
      'easy_generated' => Package.easyGenerated,
      'easy_remote' => Package.easyRemote,
      'easiest' => Package.easiest,
      'easiest_remote' => Package.easiestRemote,
      'easiest_super_remote' => Package.easiestSuperRemote,
      'fl' => Package.fl,
      _ => throw Exception('Unsupported SOURCE: $source'),
    };

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final AsyncCallback runner = switch (package) {
    Package.easy => easy.main,
    Package.easyGenerated => easy_gen.main,
    Package.easyRemote => easy_remote.main,
    Package.easiest => easiest.main,
    Package.easiestRemote => easiest_remote.main,
    Package.easiestSuperRemote => easiest_super_remote.main,
    Package.fl => fl.main,
  };

  await runner();
}
