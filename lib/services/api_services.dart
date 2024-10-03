import 'dart:async';

import 'package:http/http.dart' as http;

class ApiServices {
  String linkPdfBook = "https://books.googleusercontent.com/books/content?req=AKW5Qaf0ECRFIP1doYH9mZSxPMFZmFroJhLWm-uofPS9ScRBRJRPrYA-lCaUBRmj6Du5Kpce6veTviamR3ZEQ_XcLH09YzgKjWHi53qdmmIvih5hk67iduZI6fIlAeKRHTwdOHr3gEFvSo-R5ThelPbtG4FFfYYUn9TQ3cn3uuufni48crG06oTochcp3u3Szm8meDbwNRnt65t6ZmCw6tzRycp5jsT_oCu4wZ_ipNYrOsQ824nfPZPuMw2KL__LbBqyCC6bmgmQuGPdPAWVLZURbp9w2De3Sw";
  
  Future loadPFDBook(String uri) async {
    final url = Uri.parse(uri);
    final response = await http.get(url);
    return response.bodyBytes;
  }

  Future get books async {
    final url = Uri.parse("https://www.googleapis.com/books/v1/volumes?q=Fiction&maxResutsl=40");
    final response = await http.get(url);
    return response.body;
  }

  Future searchBook({required String searchBook}) async {
    final url = Uri.parse("https://www.googleapis.com/books/v1/volumes?q=$searchBook&maxResults=39");
    final response = await http.get(url);
    return response.body;
  }

  Future detailBook({String? id}) async {
    final url = Uri.parse("https://www.googleapis.com/books/v1/volumes/$id");
    final response = await http.get(url);
    return response.body;
  }

  Future  getTitleBook({required String categories}) async {
    final url = Uri.parse("https://www.googleapis.com/books/v1/volumes?q=$categories&maxResults=39");
    final response = await http.get(url);
    return response.body;
  }
}
