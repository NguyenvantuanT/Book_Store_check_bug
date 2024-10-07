import 'dart:async';

import 'package:book_app/pages/book_show/pdf_screen.dart';
import 'package:book_app/pages/explore_page.dart';
import 'package:book_app/pages/home_page.dart';
import 'package:flutter/material.dart';

class AppRootNotifier extends ChangeNotifier {
  final PageController _pageController = PageController(keepPage: true);
  int _selectedIndex = 0;

  int get selectIndex => _selectedIndex;
  PageController get pageController => _pageController;

  List<Widget?> _pageCache = [];
  final List<bool> _loadingStates = [false, false, false];
  bool isLoading(int index) => _loadingStates[index];

  Future<Widget>? getPage(int index) async {
    if (_pageCache.length <= index || _pageCache[index] == null) {
      _loadingStates[index] = true;
      
      await Future.delayed(const Duration(milliseconds: 100));
      
      Widget page;
      switch (index) {
        case 0:
          page = const HomePageP();
          break;
        case 1:
          page = const ExploreScreen();
          break;
        case 2:
          page = const PdfScreen();
          break;
        default:
          page = const SizedBox();
      }
      
      if (_pageCache.length <= index) {
        _pageCache.addAll(List.generate(index - _pageCache.length + 1, (_) => null));
      }
      _pageCache[index] = page;
      
      _loadingStates[index] = false;
      notifyListeners();
    }
    
    return _pageCache[index]!;
  }

  void setIndex(int index) {
    if (_selectedIndex == index) return; 

    _selectedIndex = index;
    pageController.jumpToPage(index);
    if (index < 2) {
      getPage(index + 1);
    }
    notifyListeners();
  }
}
