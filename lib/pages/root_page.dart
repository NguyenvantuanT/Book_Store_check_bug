import 'package:book_app/notifiers/app_root_notifier.dart';
import 'package:book_app/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        body: Consumer<AppRootNotifier>(
          builder: (context, value, child) {
            return PageView.builder(
                itemCount: 3,
                controller: value.pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return FutureBuilder<Widget>(
                    future: value.getPage(index),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return KeyedSubtree(
                        key: ValueKey('page_$index'),
                        child: snapshot.data ?? const SizedBox(),
                      );
                    },
                  );
                });
          },
        ),
        bottomNavigationBar: Consumer<AppRootNotifier>(
          builder: (context, value, child) {
            return Container(
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: AppColors.bgColor,
                  borderRadius: const BorderRadius.all(Radius.circular(20.0))),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: BottomNavigationBar(
                    backgroundColor: AppColors.textForBG,
                    fixedColor: AppColors.textColor,
                    unselectedItemColor: AppColors.grey.withOpacity(0.7),
                    type: BottomNavigationBarType.fixed,
                    currentIndex: value.selectIndex,
                    onTap: value.setIndex,
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
              ),
            );
          },
        ));
  }
}
