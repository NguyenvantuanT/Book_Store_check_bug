import 'package:book_app/notifiers/app_notifier.dart';
import 'package:book_app/notifiers/app_pdf_notifier.dart';
import 'package:book_app/notifiers/app_root_notifier.dart';
import 'package:book_app/notifiers/app_setting_notifier.dart';
import 'package:book_app/pages/root_page.dart';
import 'package:book_app/services/book_services.dart';
import 'package:book_app/themes/app_colors.dart';
import 'package:book_app/themes/theme_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AppNotifier>(create: (context) => AppNotifier()),
    ChangeNotifierProvider<AppSettingNotifier>(create: (context) => AppSettingNotifier()),
    ChangeNotifierProvider<AppPdfNotifier>(
        create: (context) => AppPdfNotifier()),
    ChangeNotifierProvider<AppRootNotifier>(
        create: (context) => AppRootNotifier()),
    Provider<BookService>(
      create: (context) => BookService(),
      dispose: (_, value) => value.dispose(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          textTheme: ThemeText().textThemes,
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.primaryC,
            elevation: 0,
            titleTextStyle: const TextStyle(color: Colors.black, fontSize: 22),
          )),
      home: const RootPage(),
    );
  }
}
