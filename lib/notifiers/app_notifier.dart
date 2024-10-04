import 'dart:convert';

import 'package:book_app/models/book_model.dart';
import 'package:book_app/models/detail_book_model.dart';
import 'package:book_app/services/api_services.dart';
import 'package:flutter/material.dart';

class AppNotifier extends ChangeNotifier {
  final ApiServices _apiServices = ApiServices();

  Future<BookModel> getBookData() async {
    final res = await _apiServices.books;
    final data = jsonDecode(res) as Map<String, dynamic>;
    return BookModel.fromJson(data);
  }

  Future<DetailBookModel> showBookData({required String id}) async {
    final res = await _apiServices.detailBook(id: id);
    final data = jsonDecode(res) as Map<String, dynamic>;
    return DetailBookModel.fromJson(data);
  }

  Future<BookModel> getTitleBookData({required String categories}) async {
    final res = await _apiServices.getTitleBook(categories: categories);
    final data = jsonDecode(res);
    return BookModel.fromJson(data);
  }

  Future<DetailBookModel> getSearchBookData(
      {required String searchBook}) async {
    final res = await _apiServices.searchBook(searchBook: searchBook);
    final data = jsonDecode(res) as Map<String, dynamic>;
    return DetailBookModel.fromJson(data);
  }
}
