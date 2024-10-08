import 'package:book_app/notifiers/app_setting_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Favorite page",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        body: Consumer<AppSettingNotifier>(
          builder: (context, value, child) {
            final favBook = value.favoriteBooks;
            return ListView.separated(
              separatorBuilder: (_,__) => const SizedBox(height: 10.0),
              itemCount: favBook.length,
              itemBuilder: (context,index){
                final book = favBook[index];
                return ListTile(
                  leading: Image.network(book.thumbnailUrl, errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),),
                  title: Text(book.title),
                  subtitle: Text(book.authors[0]),
                );
              },
            );
          },
        ));
  }
}
