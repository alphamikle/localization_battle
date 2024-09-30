import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:easiest_remote_localization/easiest_remote_localization.dart';

class RemoteSourcesService {
  Future<List<CDNSource>> fetchSources() async {
    final response = await Dio().get('https://indieloper.b-cdn.net/easiest_localization/remote_localizations.json');
    final List<CDNSource> sources = (response.data as List<dynamic>).map<CDNSource>(
      (json) {
        final List<String> parts = (json['locale'] as String).split('_');
        final String language = parts.first;
        final String? country = parts.length > 1 ? parts.last : null;

        return CDNSource(
          locale: Locale(language, country),
          path: json['path'],
          type: SourceType.json,
        );
      },
    ).toList();
    return sources;
  }
}
