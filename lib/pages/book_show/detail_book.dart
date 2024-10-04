import 'package:book_app/components/app_button.dart';
import 'package:book_app/models/book_model.dart';
import 'package:book_app/notifiers/app_notifier.dart';
import 'package:book_app/pages/book_show/pdf_screen.dart';
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
    return Scaffold(
      backgroundColor: AppColors.primaryC,
      body: Consumer<AppNotifier>(
        builder: ((context, value, child) {
          return widget.id != null
              ? FutureBuilder(
                  future: value.showBookData(id: widget.id ?? ""),
                  builder: (context, snapshot) {
                    final item = snapshot.data?.volumeInfo;
                    String pathPDF =
                        snapshot.data?.accessInfo?.pdf?.acsTokenLink ?? "";
                    return SingleChildScrollView(
                        child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: height,
                              width: width,
                              margin: const EdgeInsets.only(top: 167),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              decoration: BoxDecoration(
                                  color: AppColors.bgColor,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                  )),
                              child: Column(
                                children: [
                                  const SizedBox(height: 110),
                                  _buildBody(
                                      height, width, item, context, pathPDF),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 70.0,
                              left: 0,
                              right: 0,
                              child: _buildImage(height, width, item),
                            )
                          ],
                        ),
                      ],
                    ));
                  })
              : const Center(
                  child: Text("Opps No Data Found!"),
                );
        }),
      ),
    );
  }

  Widget _buildImage(double height, double width, VolumeInfo? item) {
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
            child: Image(
                fit: BoxFit.cover,
                image: NetworkImage(item?.imageLinks?.thumbnail ?? ""),
                errorBuilder: (_, __, ___) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(double height, double width, VolumeInfo? item,
      BuildContext context, String pathPDF) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            item?.title ?? "No Name Book",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
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
            Container(
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PdfScreen(
                    ),
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
            ),
          ],
        ),
        _buildTitle(context, "Details"),
        _showDoc(context, item),
        _buildTitle(context, "Description"),
        ReadMoreText(
          item?.description ?? "No Description",
          trimLines: 6,
          colorClickableText: AppColors.black,
          trimMode: TrimMode.Line,
          trimCollapsedText: '...Read More',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontSize: 15)
              .copyWith(color: AppColors.grey),
          trimExpandedText: ' Less',
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
                maxLines: 1,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 16.0, color: AppColors.grey),
              ),
              Text(
                item?.publisher ?? "No Publisher",
                maxLines: 1,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 16.0, color: AppColors.grey),
              ),
              Text(
                item?.publishedDate ?? "No Publisher Data",
                maxLines: 1,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 16.0, color: AppColors.grey),
              ),
              Text(
                item?.categories?[0] ?? "No Categories",
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
              .displayLarge!
              .copyWith(fontSize: 18.0),
        ),
      ),
    );
  }
}
