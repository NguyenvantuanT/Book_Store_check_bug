import 'package:book_app/models/book_exlpore._model.dart';
import 'package:flutter/material.dart';

class AppSettingNotifier extends ChangeNotifier {
  final List<Book> _favoriteBooks = [];
  List<Book> get favoriteBooks => _favoriteBooks;

  void addTofavoriteBook(Book book) {
    if (!_favoriteBooks.contains(book)) {
      _favoriteBooks.add(book);
    }
    notifyListeners();
    print("ok");
  }

  List<Map<String, dynamic>> items = [
    {
      'icon': const Icon(Icons.favorite),
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
