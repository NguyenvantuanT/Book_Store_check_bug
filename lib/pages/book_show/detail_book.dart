import 'package:book_app/components/app_button.dart';
import 'package:book_app/models/book_model.dart';
import 'package:book_app/notifiers/app_notifier.dart';
import 'package:book_app/themes/app_colors.dart';
import 'package:book_app/utils/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class DetailBook extends StatefulWidget {
  const DetailBook({super.key, this.id});

  final String? id;

  @override
  State<DetailBook> createState() => _DetailBookState();
}

class _DetailBookState extends State<DetailBook> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final data = Provider.of<AppNotifier>(context);
    return Scaffold(
      body: FutureBuilder(
          future: data.showBookData(id: widget.id ?? ""),
          builder: (context, snapshot) {
            final item = snapshot.data?.volumeInfo;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: height,
                        width: width,
                        color: AppColors.yellow,
                      ),
                      Positioned(
                        top: 200,
                        left: 0,
                        bottom: 0,
                        right: 0,
                        child: _buildBgHeard(),
                      ),
                      Positioned(
                        top: 120,
                        left: 0,
                        right: 0,
                        child: _buildBody(height, width, item, context),
                      )
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }

  Widget _buildBody(
      double height, double width, VolumeInfo? item, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
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
            child: Image(
                fit: BoxFit.cover,
                image: NetworkImage(item?.imageLinks?.thumbnail ?? "")),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          item?.title ?? "No Name Book",
          style: Theme.of(context).textTheme.displayLarge,
        ),
        Text(
          (item?.authors?[0] ?? "Censored").toUpperCase(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              item?.printType ?? "Book",
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
                  (item?.pageCount ?? 0).toVND,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: AppColors.bgColor),
                ),
              ),
            ),
            Text(
              "${item?.pageCount ?? 0} pages",
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
            ),
            AppButton(
              icon: Icon(
                Icons.favorite_outline,
                color: AppColors.black,
              ),
              text: "WISHLIST",
            ),
          ],
        ),
        _buildTitle(context, "Details"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: _showDoc(context, item),
        ),
        _buildTitle(context, "Description"),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: ReadMoreText(
            item?.description ?? "No Description",
            trimLines: 6,
            colorClickableText: AppColors.black,
            trimMode: TrimMode.Line,
            trimCollapsedText: '...Read More',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 14),
            trimExpandedText: ' Less',
          ),
        ),
      ],
    );
  }

  Widget _showDoc(BuildContext context, VolumeInfo? item) {
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
                item?.authors?[0] ?? "No Auhtor Value",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 16.0, color: AppColors.grey),
              ),
              Text(
                item?.publisher ?? "No Publisher",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 16.0, color: AppColors.grey),
              ),
              Text(
                item?.publishedDate ?? "No Publisher Data",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 16.0, color: AppColors.grey),
              ),
              Text(
                item?.categories?[0] ?? "No Categories",
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
              .displayLarge!
              .copyWith(fontSize: 18.0),
        ),
      ),
    );
  }

  Widget _buildBgHeard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
    );
  }
}
