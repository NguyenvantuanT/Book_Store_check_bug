// lib/models/book.dart
class Book {
  final String id;
  final String title;
  final List<String> authors;
  final String description;
  final String thumbnailUrl;
  final String previewLink;
  final String publisher;
  final String publishedDate;
  final List<String> categories;
  final String pdfLink;
  final int pageCount;
  final double rating;

  Book({
    required this.id,
    required this.title,
    required this.authors,
    required this.description,
    required this.thumbnailUrl,
    required this.previewLink,
    required this.publisher,
    required this.publishedDate,
    required this.categories,
    required this.pdfLink,
    required this.pageCount,
    required this.rating,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    var volumeInfo = json['volumeInfo'];
    var accessInfo = json['accessInfo'];

    return Book(
      id: json['id'] ?? 'No value',
      title: volumeInfo['title'] ?? 'No Title',
      authors: volumeInfo['authors'] != null
          ? List<String>.from(volumeInfo['authors'])
          : ['Unknown Author'],
      description: volumeInfo['description'] ?? 'No description available',
      thumbnailUrl: volumeInfo['imageLinks']?['thumbnail'] ?? 'No value',
      previewLink: volumeInfo['previewLink'] ?? 'No value',
      publisher: volumeInfo['publisher'] ?? 'No value',
      publishedDate: volumeInfo['publishedDate'] ?? 'No value',
      categories: volumeInfo['categories'] != null
          ? List<String>.from(volumeInfo['categories'])
          : ['Unknown Categories'],
      pdfLink: accessInfo['pdf']?['downloadLink'] ?? 'No value',
      pageCount: volumeInfo['pageCount'] ?? 0,
      rating: (volumeInfo['averageRating'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'volumeInfo': {
          'title': title,
          'authors': authors,
          'publisher': publisher,
          'publishedDate': publishedDate,
          'categories': categories,
          'description': description,
          'imageLinks': {
            'thumbnail': thumbnailUrl,
          },
          'previewLink': previewLink,
          'pageCount': pageCount,
          'averageRating': rating,
        },
        'accessInfo': {
          'pdf': {
            'downloadLink': pdfLink,
          },
        },
      };
}
