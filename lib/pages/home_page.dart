import 'package:book_app/components/app_search_box.dart';
import 'package:book_app/notifiers/app_book_explore.dart';
import 'package:book_app/pages/book_show/status_book.dart';
import 'package:book_app/pages/explore_page.dart';
import 'package:book_app/services/book_services.dart';
import 'package:book_app/themes/app_colors.dart';
import 'package:book_app/utils/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Status {
  fiction,
  animeManga,
  actionAdventure,
  novel,
  horror,
}

class HomePageP extends StatelessWidget {
  const HomePageP({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExploreProvider(
        context.read<BookService>(),
      )..loadMoreBooks(),
      child: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final _debouncer = Debouncer(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: Status.values.length, vsync: this);
    tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (!tabController.indexIsChanging) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _debouncer.run(() async {
        await context
            .read<ExploreProvider>()
            .setCurrentQuery(tabController.index);
      });
    });
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
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: Text(
                    "Book Store",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
              ),
              SliverAppBar(
                  backgroundColor: AppColors.bgColor,
                  flexibleSpace: const AppSearchBox()),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0)
                      .copyWith(bottom: 10.0),
                  child: Text(
                    "Top Sellers",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ),
              SliverPersistentHeader(
                floating: true,
                pinned: true,
                delegate: MyDelegate(
                  tabBar: TabBar(
                    dividerColor: Colors.transparent,
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
            children: List<Widget>.generate(
              Status.values.length,
              (index) => const CategoriesPage(),
            ),
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
    return Container(height: 100.0, color: AppColors.bgColor, child: tabBar);
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

List<Widget> tab = Status.values
    .map(
      (e) => Tab(
        height: 50.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Text(
            e.tabLabel,
            style: const TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    )
    .toList();
