import 'package:book_app/components/app_button.dart';
import 'package:book_app/models/book_exlpore._model.dart';
import 'package:book_app/notifiers/app_setting_notifier.dart';
import 'package:book_app/pages/book_show/pdf_screen.dart';
import 'package:book_app/themes/app_colors.dart';
import 'package:book_app/utils/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class DetailBook extends StatelessWidget {
  const DetailBook({
    super.key,
    required this.book,
  });

  final Book book;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.primaryC,
      body: SingleChildScrollView(
          child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: height,
                width: width,
                margin: const EdgeInsets.only(top: 167),
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                    color: AppColors.bgColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    )),
                child: Column(
                  children: [
                    const SizedBox(height: 110),
                    _buildBody(height, width, book, context),
                  ],
                ),
              ),
              Positioned(
                top: 70.0,
                left: 0,
                right: 0,
                child: _buildImage(height, width, book),
              )
            ],
          ),
        ],
      )),
    );
  }

  Widget _buildImage(double height, double width, Book book) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: height / 4,
          width: width / 3,
          decoration: BoxDecoration(
            color: AppColors.bgColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: AppColors.shadow,
                  offset: const Offset(3.0, 3.0),
                  blurRadius: 6.0)
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              book.thumbnailUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) =>
                  const Center(child: Icon(Icons.error)),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(
      double height, double width, Book book, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            book.title,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(fontSize: 20),
          ),
        ),
        Text(
          (book.authors[0]).toUpperCase(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Book",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 9.0, vertical: 5.0),
                decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  (book.pageCount).toVND,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: AppColors.bgColor),
                ),
              ),
            ),
            Text(
              "${book.pageCount} pages",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        const SizedBox(height: 25.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AppButton(
              text: "VIEW ONLINE",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PdfScreen(),
                  ),
                );
              },
            ),
            AppButton(
              icon: Icon(
                Icons.favorite_outline,
                color: AppColors.black,
              ),
              text: "WISHLIST",
              onTap: () => Provider.of<AppSettingNotifier>(context,listen: false).addTofavoriteBook(book),
            ),
          ],
        ),
        _buildTitle(context, "Details"),
        _showDoc(context, book),
        _buildTitle(context, "Description"),
        ReadMoreText(
          book.description,
          trimLines: 4,
          colorClickableText: AppColors.black,
          trimMode: TrimMode.Line,
          trimCollapsedText: '...Read More',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: AppColors.textColor,
          ),
          trimExpandedText: ' Less',
        ),
      ],
    );
  }

  Widget _showDoc(BuildContext context, Book book) {
    return Row(
      children: [
        Expanded(
          // flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Author",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 16.0),
              ),
              Text(
                "Publisher",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 16.0),
              ),
              Text(
                "Publisher Date",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 16.0),
              ),
              Text(
                "Categorie",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 16.0),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          // flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                book.authors[0],
                maxLines: 1,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 16.0, color: AppColors.grey),
              ),
              Text(
                book.publisher,
                maxLines: 1,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 16.0, color: AppColors.grey),
              ),
              Text(
                book.publishedDate,
                maxLines: 1,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 16.0, color: AppColors.grey),
              ),
              Text(
                book.categories[0],
                maxLines: 1,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 16.0, color: AppColors.grey),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildTitle(BuildContext context, String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(fontSize: 18.0),
        ),
      ),
    );
  }
}
