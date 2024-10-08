import 'package:flutter/material.dart';

class AppSettingNotifier extends ChangeNotifier {
  List<Map<String, dynamic>> items = [
    {
        'icon':const Icon(Icons.favorite),
        'title': 'Favorites',
        // 'function': () => _pushPage(const FavoritesRoute()),
      },
      {
        'icon': const Icon(Icons.download),
        'title': 'Downloads',
        // 'function': () => _pushPage(const DownloadsRoute()),
      },
      {
        'icon': const Icon(Icons.mode),
        'title': 'Dark Mode',
        'function': null,
      },
      {
        'icon': const Icon(Icons.info),
        'title': 'About',
        // 'function': () => showAbout(),
      },
      {
        'icon': const Icon(Icons.file_copy_outlined),
        'title': 'Open Source Licenses',
        // 'function': () => _pushPage(const LicensesRoute()),
      },
  ];
}