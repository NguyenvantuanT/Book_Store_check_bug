// lib/screens/explore_screen.dart
import 'dart:async';

import 'package:book_app/components/app_search_box.dart';
import 'package:book_app/models/book_exlpore._model.dart';
import 'package:book_app/notifiers/app_book_explore.dart';
import 'package:book_app/pages/book_show/detail_book.dart';
import 'package:book_app/services/book_services.dart';
import 'package:book_app/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExploreProvider(
        context.read<BookService>(),
      )..loadMoreBooks(),
      child: const ExploreView(),
    );
  }
}

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  final _debouncer = Debouncer(milliseconds: 1000);

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        title: const Text('Explore Books'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: AppSearchBox(
            controller: _controller,
            onChange: (value) {
              _debouncer.run(() {
                context.read<ExploreProvider>().searchBooks(value ?? "The A");
              });
            },
          ),
        ),
      ),
      body: const BookGridView(),
    );
  }
}

class BookGridView extends StatefulWidget {
  const BookGridView({super.key});

  @override
  State<BookGridView> createState() => _BookGridViewState();
}

class _BookGridViewState extends State<BookGridView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<ExploreProvider>().loadMoreBooks();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExploreProvider>(
      builder: (context, provider, child) {
        if (provider.books.isEmpty && provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.books.isEmpty && provider.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("No data "),
                ElevatedButton(
                  onPressed: provider.refreshBooks,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: provider.refreshBooks,
          child: GridView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: provider.books.length + (provider.hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == provider.books.length) {
                return const Center(child: CircularProgressIndicator());
              }

              final book = provider.books[index];
              return BookCard(book: book);
            },
          ),
        );
      },
    );
  }
}

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailBook(
                        book: book,
                      )));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: book.thumbnailUrl.isNotEmpty
                  ? Image.network(
                      book.thumbnailUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(child: Icon(Icons.error)),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                    )
                  : const Center(child: Icon(Icons.book)),
            ),
            Container(
              color: AppColors.textForBG,
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold)
                    ),
                    Text(
                      book.authors.join(', '),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 12.0)
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
