import 'package:book_app/pages/book_show/detail_book.dart';
import 'package:book_app/pages/book_show/pdf_screen.dart';
import 'package:book_app/pages/home_page.dart';
import 'package:book_app/themes/app_colors.dart';
import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
int selectIndex = 0;
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children:const [
          HomePage(),
          DetailBook(),
          PdfScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.bgColor,
          fixedColor: AppColors.primaryD,
          type: BottomNavigationBarType.fixed,
          currentIndex: selectIndex,
          onTap: (int index) {
            setState(() {
              selectIndex = index;
              _pageController.jumpToPage(selectIndex);
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              label: "Explore",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: "Settings",
            ),
           
          ]),
    );
  }
}