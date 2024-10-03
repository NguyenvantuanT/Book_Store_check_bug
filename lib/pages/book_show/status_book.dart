import 'package:book_app/models/book_model.dart';
import 'package:book_app/notifiers/app_notifier.dart';
import 'package:book_app/notifiers/app_status_notifier.dart';
import 'package:book_app/pages/book_show/detail_book.dart';
import 'package:book_app/themes/app_colors.dart';
import 'package:book_app/utils/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatusBook extends StatelessWidget {
  const StatusBook({super.key});

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<AppNotifier>(context);
    var status = Provider.of<AppStatusNotifier>(context).status;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: FutureBuilder(
          future: data.getTitleBookData(categories: status.displayName),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: AppColors.black,
              ));
            }

            if (snapshot.hasError) {
              print(snapshot.error.toString());
              return const Center(
                child: Text("No connect !"),
              );
            }

            if (snapshot.hasData && snapshot.data?.items != null) {
              return ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  // physics: const NeverScrollableScrollPhysics(),
                  // shrinkWrap: true,
                  separatorBuilder: (_, __) => const SizedBox(height: 20),
                  itemCount: snapshot.data!.items!.length,
                  itemBuilder: (context, index) {
                    var item = snapshot.data!.items![index];
                    return GestureDetector(
                      onTap: () => _showDetail(context, item.id ?? ""),
                      child: SizedBox(
                        height: size.height / 4,
                        child: Row(
                          children: [
                            _buildImage(size, item),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 40.0),
                                child: _buildTitle(item),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }
            return const Center(
              child: Text("No data available!"),
            );
          }),
    );
  }

  void _showDetail(BuildContext context, String id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailBook(
          id: id,
        ),
      ),
    );
  }

  Widget _buildTitle(Items item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          item.volumeInfo?.title ?? "No title available",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: AppColors.black,
              fontSize: 15,
              fontWeight: FontWeight.w500),
        ),
        Text(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          item.volumeInfo?.authors?[0] ?? "No author available",
          style: TextStyle(
              color: AppColors.blue, fontSize: 13, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 20.0),
        Text(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          "\$ ${(item.volumeInfo?.pageCount ?? 0).toVND}",
          style: TextStyle(
              color: AppColors.grey, fontSize: 15, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget _buildImage(Size size, Items item) {
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
        child: Image(
          image: NetworkImage(
            item.volumeInfo?.imageLinks?.thumbnail ?? "",
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
