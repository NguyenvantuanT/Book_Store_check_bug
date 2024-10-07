import 'package:book_app/models/book_exlpore._model.dart';
import 'package:book_app/pages/home_page.dart';
import 'package:book_app/services/book_services.dart';
import 'package:book_app/utils/app_extension.dart';
import 'package:flutter/foundation.dart';

class ExploreProvider extends ChangeNotifier {
  final BookService _bookService;
  List<Book> _books = [];
  bool _isLoading = false;
  String? _error;
  int _currentPage = 0;
  Status _currentStatus = Status.fiction;
  bool _hasMore = true;

  ExploreProvider(this._bookService);

  List<Book> get books => _books;
  bool get isLoading => _isLoading;
  Status get currentStatus => _currentStatus;
  String get currentQuery => _currentStatus.displayName;
  String? get error => _error;
  bool get hasMore => _hasMore;


 
  Future<void> setCurrentQuery(int index) async {
    final newStatus = Status.values[index];
    if (_currentStatus == newStatus) return;
    _currentStatus = newStatus;
    _books = [];
    _currentPage = 0;
    _hasMore = true;
    _error = null;
    await Future.delayed(const Duration(milliseconds: 50));
    await loadMoreBooks();
    notifyListeners();
  }

  Future<void> loadMoreBooks() async {
    print("Inside loadMoreBooks at start: $_currentStatus");
    final currentStatus = _currentStatus;
    if (_isLoading || !_hasMore) return;

    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final newBooks = await _bookService.fetchBooks(
        query: currentStatus.displayName,
        startIndex: _currentPage * 20,
      );
      print("Inside loadMoreBooks after fetch: $_currentStatus");

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
      print("Inside loadMoreBooks at end: $_currentStatus");
      notifyListeners();
    }
  }

  Future<void> searchBooks(String query) async {
    _currentStatus = Status.fiction; 
    _books = [];
    _currentPage = 0;
    _hasMore = true;
    _error = null;
    notifyListeners();

    await _bookService
        .fetchBooks(
      query: query,
      startIndex: 0,
    )
        .then((newBooks) {
      if (newBooks.isNotEmpty) {
        _books = newBooks;
        _currentPage = 1;
      } else {
        _hasMore = false;
      }
      notifyListeners();
    }).catchError((e) {
      _error = e.toString();
      notifyListeners();
    });
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
