import 'package:book_app/models/book_exlpore._model.dart';
import 'package:book_app/notifiers/app_book_explore.dart';
import 'package:book_app/pages/book_show/detail_book.dart';
import 'package:book_app/services/book_services.dart';
import 'package:book_app/themes/app_colors.dart';
import 'package:book_app/utils/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExploreProvider(
        context.read<BookService>(),
      )..loadMoreBooks(),
      child: const StatusBook(),
    );
  }
}

class StatusBook extends StatefulWidget {
  const StatusBook({super.key});

  @override
  State<StatusBook> createState() => _StatusBookState();
}

class _StatusBookState extends State<StatusBook> {
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        body: Consumer<ExploreProvider>(
          builder: (context, provider, child) {
            if (provider.books.isEmpty && provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (provider.books.isEmpty && provider.error != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(provider.error!),
                    ElevatedButton(
                      onPressed: provider.refreshBooks,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            return ListView.separated(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ).copyWith(left: 20.0, right: 8.0),
                // physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (_, __) => const SizedBox(height: 20),
                itemCount: provider.books.length + (provider.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  final book = provider.books[index];
                  if (index == provider.books.length) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    height: size.height / 4,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: AppColors.textForBG,
                        borderRadius: BorderRadius.circular(15.0)),
                    child: GestureDetector(
                      onTap: () => _showDetail(context, book),
                      child: SizedBox(
                        height: size.height / 4,
                        child: Row(
                          children: [
                            _buildImage(size, book.thumbnailUrl),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 40.0),
                                child: _buildTitle(context, book),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          },
        ));
  }

  void _showDetail(BuildContext context, Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailBook(
          book: book,
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context, Book book) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(book.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headlineMedium),
        Text(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          book.authors[0],
          style: TextStyle(
              color: AppColors.blue, fontSize: 13, fontWeight: FontWeight.w400),
        ),
        Expanded(
          child: Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            "\$ ${(book.pageCount).toVND}",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      ],
    );
  }

  Widget _buildImage(Size size, String thumbnailUrl) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.bgColor,
          border: Border.all(color: AppColors.bgColor),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: AppColors.shadow,
                offset: const Offset(3.0, 3.0),
                blurRadius: 6.0)
          ]),
      height: size.height * 0.4,
      width: size.width * 0.30,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            thumbnailUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) =>
                const Center(child: Icon(Icons.error)),
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
          )),
    );
  }
}
