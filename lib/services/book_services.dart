// lib/services/book_service.dart
import 'dart:convert';
import 'package:book_app/models/book_exlpore._model.dart';
import 'package:http/http.dart' as http;

class BookService {
  static const String baseUrl = 'https://www.googleapis.com/books/v1/volumes';
  final http.Client _client;

  BookService({
    http.Client? client,
  }) : 
       _client = client ?? http.Client();

  Future<List<Book>> fetchBooks({
    required String query,
    int startIndex = 0,
    int maxResults = 20,
  }) async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl?q=$query&startIndex=$startIndex&maxResults=$maxResults'),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Connection timeout'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['items'] == null) return [];

        final List<Book> books = (data['items'] as List)
            .map((item) => Book.fromJson(item))
            .toList();

        // Cache the results
        
        return books;
      } else {
        throw Exception('Failed to load books');
      }
    } catch (e) {
      throw Exception('Error fetching books: $e');
    }
  }

  void dispose() {
    _client.close();
  }
}