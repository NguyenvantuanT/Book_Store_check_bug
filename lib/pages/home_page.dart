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
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                  child: Text(
                    "Book Store",
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 20.0,
                    ),
                  ),
                ),              ),
              SliverAppBar(
                  backgroundColor: AppColors.bgColor,
                  expandedHeight: 20.0,
                  flexibleSpace: const AppSearchBox()),
              SliverPersistentHeader(
                floating: true,
                pinned: true,
                delegate: MyDelegate(
                  tabBar: TabBar(
                    tabAlignment: TabAlignment.center,
                    controller: tabController,
                    // dividerColor: Colors.transparent,
                    indicatorColor: AppColors.primaryD,
                    isScrollable: true,
                    labelStyle: TextStyle(
                      color: AppColors.primaryD,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                    unselectedLabelStyle: TextStyle(
                      color: AppColors.grey.withOpacity(0.7),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    tabs: tab,
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            physics: const AlwaysScrollableScrollPhysics(),
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
    return Container(height: 40, color: AppColors.bgColor, child: tabBar);
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

List<Tab> tab = const [
  Tab(text: "Anime", height: 20),
  Tab(text: "Adventure", height: 20),
  Tab(text: "Novel", height: 20),
  Tab(text: "Horror", height: 20),
];
