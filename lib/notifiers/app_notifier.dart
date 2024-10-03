import 'dart:convert';
import 'dart:io';

import 'package:book_app/models/book_model.dart';
import 'package:book_app/models/detail_book_model.dart';
import 'package:book_app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class AppNotifier extends ChangeNotifier {
  final ApiServices _apiServices = ApiServices();

  String? _filePath;
  String? get filePath => _filePath;

  Future<void> getPDFBook({required String uri}) async {
    final res = await _apiServices.loadPFDBook(uri);
    final directory = await getApplicationDocumentsDirectory();
    _filePath = '${directory.path}/sample.pdf';
    File file = File(_filePath ?? "");
    await file.writeAsBytes(res);
    notifyListeners();
  }

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
