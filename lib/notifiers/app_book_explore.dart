import 'package:book_app/models/book_exlpore._model.dart';
import 'package:book_app/pages/home_page.dart';
import 'package:book_app/services/book_services.dart';
import 'package:book_app/utils/app_extension.dart';
import 'package:flutter/material.dart';

class ExploreProvider extends ChangeNotifier {
  final BookService _bookService;
  TabController? _tabController;
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
  TabController? get tabController => _tabController;

  void initTabController(TabController controller) {
    _tabController = controller;
    _tabController?.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (!_tabController!.indexIsChanging) {
      final newIndex = _tabController?.index ?? 0;
      setCurrentQuery(newIndex);
    }
  }

  Future<void> setCurrentQuery(int index) async {
    final newStatus = Status.values[index];
    if (_currentStatus == newStatus) return;

    _currentStatus = newStatus;
    await _resetAndLoad();
  }

  Future<void> _resetAndLoad() async {
    _books = [];
    _currentPage = 0;
    _hasMore = true;
    _error = null;
    notifyListeners();
    
    await loadMoreBooks();
  }

  Future<void> loadMoreBooks() async {
    if (_isLoading || !_hasMore) return;

    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final newBooks = await _bookService.fetchBooks(
        query: currentQuery,
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
      print('Error loading books: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchBooks(String query) async {
    try {
      _isLoading = true;
      _books = [];
      _currentPage = 0;
      _hasMore = true;
      _error = null;
      notifyListeners();

      final newBooks = await _bookService.fetchBooks(
        query: query,
        startIndex: 0,
      );

      if (newBooks.isEmpty) {
        _hasMore = false;
      } else {
        _books = newBooks;
        _currentPage = 1;
      }
    } catch (e) {
      _error = e.toString();
      print('Error searching books: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshBooks() async {
    await _resetAndLoad();
  }

  void reset() {
    _books = [];
    _currentPage = 0;
    _hasMore = true;
    _error = null;
    _currentStatus = Status.fiction;
    notifyListeners();
  }

  bool get canLoadMore => !_isLoading && _hasMore && _error == null;

  Future<void> switchToStatus(Status status) async {
    if (_currentStatus == status) return;
    _currentStatus = status;
    _tabController?.animateTo(status.index);
    await _resetAndLoad();
  }

  @override
  void dispose() {
    _tabController?.removeListener(_handleTabChange);
    _tabController?.dispose();
    super.dispose();
  }
}