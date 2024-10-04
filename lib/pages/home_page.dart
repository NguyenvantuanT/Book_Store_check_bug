import 'package:book_app/components/app_search_box.dart';
import 'package:book_app/notifiers/app_status_notifier.dart';
import 'package:book_app/pages/book_show/status_book.dart';
import 'package:book_app/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Status {
  animeManga,
  actionAdventure,
  novel,
  horror,
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        Provider.of<AppStatusNotifier>(context, listen: false)
            .updateView(tabController.index);
      }
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Padding(
        padding: const EdgeInsets.symmetric().copyWith(
          top: MediaQuery.of(context).padding.top + 6.0,
        ),
        child: NestedScrollView(
          physics: const ClampingScrollPhysics(),
          headerSliverBuilder: (context, isScolled) {
            return [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: Text(
                    "Book Store",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
              ),
              SliverAppBar(
                  backgroundColor: AppColors.bgColor,
                  expandedHeight: 20.0,
                  flexibleSpace: const AppSearchBox()),
              SliverPersistentHeader(
                floating: true,
                pinned: true,
                delegate: MyDelegate(
                  tabBar: TabBar(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 6.0),
                    indicator: BoxDecoration(
                      color: AppColors.primaryC,
                      border: Border.all(color: AppColors.discount, width: 1.2),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    tabAlignment: TabAlignment.center,
                    controller: tabController,
                    indicatorColor: Colors.transparent,
                    isScrollable: true,
                    labelStyle: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal),
                    unselectedLabelStyle: TextStyle(
                      color: AppColors.grey.withOpacity(0.7),
                    ),
                    tabs: tab,
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: tabController,
            children: List.generate(4, (index) => const StatusBook()),
          ),
        ),
      ),
    );
  }
}

class MyDelegate extends SliverPersistentHeaderDelegate {
  MyDelegate({required this.tabBar});
  final TabBar tabBar;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(height: 45, color: AppColors.bgColor, child: tabBar);
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

List<Widget> tab = const [
  Tab(text: "Anime", height: 20),
  Tab(text: "Adventure", height: 20),
  Tab(text: "Novel", height: 20),
  Tab(text: "Horror", height: 20),
];
