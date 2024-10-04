import 'dart:io';

import 'package:book_app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class AppPdfNotifier extends ChangeNotifier {
  final ApiServices _apiServices = ApiServices();

  String? _filePath;
  int? _page;
  int? _total;

  String? get filePath => _filePath;
  int? get page => _page;
  int? get total => _total;

  void getPage(int? total, int? page) {
    _total = total;
    _page = page;
    notifyListeners();
  }

  Future<void> downloadPDF(String url) async {
    final res = await _apiServices.loadPFDBook(uri: url);
    final directory = await getApplicationDocumentsDirectory();
    _filePath = '${directory.path}/sample.pdf';
    final file = File(_filePath!);
    await file.writeAsBytes(res);
    notifyListeners();
  }
}
