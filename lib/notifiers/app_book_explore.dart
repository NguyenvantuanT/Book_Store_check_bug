// lib/providers/explore_provider.dart
import 'package:book_app/models/book_exlpore._model.dart';
import 'package:book_app/services/book_services.dart';
import 'package:flutter/foundation.dart';

class ExploreProvider extends ChangeNotifier {
  final BookService _bookService;
  
  List<Book> _books = [];
  bool _isLoading = false;
  String? _error;
  int _currentPage = 0;
  String _currentQuery = 'flutter programming';
  bool _hasMore = true;

  ExploreProvider(this._bookService);

  // Getters
  List<Book> get books => _books;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasMore => _hasMore;

  Future<void> loadMoreBooks() async {
    if (_isLoading || !_hasMore) return;

    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final newBooks = await _bookService.fetchBooks(
        query: _currentQuery,
        startIndex: _currentPage * 20,
      );

      if (newBooks.isEmpty) {
        _hasMore = false;
      } else {
        _books.addAll(newBooks);
        _currentPage++;
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchBooks(String query) async {
    if (_currentQuery == query) return;

    _currentQuery = query;
    _books = [];
    _currentPage = 0;
    _hasMore = true;
    _error = null;
    
    await loadMoreBooks();
  }

  Future<void> refreshBooks() async {
    _books = [];
    _currentPage = 0;
    _hasMore = true;
    _error = null;
    notifyListeners();

    await loadMoreBooks();
  }
}